#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Definition:: geostore
#
# (C) 2013, FAO Forestry Department (http://www.fao.org/forestry/)
#
# This application is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation;
# version 3.0 of the License.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.


# As we need two instances of GeoStore for the full NFMS portal we are using a definition

define :geostore do
  include_recipe "tomcat::base"
  include_recipe "unredd-nfms-portal::db_conf"

  tomcat_user = node['tomcat']['user']

  root_dir                     = params[:root_dir]
  geostore_instance_name       = params[:name]
  geostore_db_schema           = params[:db_schema]
  geostore_db_user             = params[:db_user]
  geostore_db_pwd              = params[:db_password]
  geostore_postgres_schema_url = params[:postgres_schema_url]
  tomcat_instance_name         = params[:tomcat_instance_name]

  db_name = node['unredd-nfms-portal']['db_name']

  temp_dir = '/var/tmp'

  tomcat geostore_instance_name do
    user tomcat_user
    shutdown_port params[:tomcat_shutdown_port]
    ajp_port params[:tomcat_ajp_port]
    http_port params[:tomcat_http_port]
    jvm_opts [
      "-server",
      "-Xms#{params[:xms]}",
      "-Xmx#{params[:xmx]}",
      "-Dgeostore-ovr=file:#{root_dir}/#{geostore_instance_name}/geostore-datasource-ovr.properties",
      "-Duser.timezone=GMT",
      "-Djava.awt.headless=true"
    ]
    manage_config_file true
  end

  # Configure postgis
  postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

  # CREATE USER <geostore_db_user> LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
  # TODO: check that the following corresponds to the above
  postgresql_database_user geostore_db_user do
    connection postgresql_connection_info
    password   geostore_db_pwd
    action     :create
  end

  # # createdb -O <geostore_db_user> <geostore_db>
  # # TODO: check that the following corresponds to the above
  # postgresql_database geostore_db_name do
  #   connection postgresql_connection_info
  #   encoding   'DEFAULT'
  #   #encoding   'UTF8'
  #   #collation  'en_US.utf8'
  #   tablespace 'DEFAULT'
  #   owner      geostore_db_user
  #   action     :create
  #   #connection_limit '-1'
  # end


  # Download the geostore postgres schema file only if the remote source has changed (uses http_request resource)
  remote_file "#{temp_dir}/create_schema_postgres.sql" do
    source geostore_postgres_schema_url
    owner 'postgres'
    retries 10
    retry_delay 60
    action :nothing
  end
  http_request "HEAD #{geostore_postgres_schema_url}" do
    message ""
    url geostore_postgres_schema_url
    action :head
    if ::File.exists?("#{temp_dir}/create_schema_postgres.sql")
      headers "If-Modified-Since" => ::File.mtime("#{temp_dir}/create_schema_postgres.sql").httpdate
    end
    retries 10
    retry_delay 60
    notifies :create, resources(:remote_file => "#{temp_dir}/create_schema_postgres.sql"), :immediately
  end

  user_schema geostore_db_schema do
    #db_schema   = node['unredd-nfms-portal']['diss_geoserver']['db_schema']
    db_user     geostore_db_user
    db_password geostore_db_pwd
  end

  geostore_postgresql_connection_info = { :host => "localhost", :username => geostore_db_user, :password => geostore_db_pwd }
  # Create the geostore tables and sequences
  postgresql_database "configure #{geostore_instance_name} db" do
    connection geostore_postgresql_connection_info
    sql { ::File.open("#{temp_dir}/create_schema_postgres.sql").read }
    database_name db_name

    action :query

    #not_if "psql -c \"select * from pg_class where relname='gs_attribute' and relkind='r'\" #{geostore_db} | grep -c gs_attribute", :user => 'postgres'
    not_if "psql -tc \"SELECT * FROM information_schema.tables WHERE table_schema='#{geostore_db_schema}' AND table_name='gs_attribute'\" #{db_name} | grep -c gs_attribute", :user => 'postgres'
  end

  directory "#{root_dir}/#{geostore_instance_name}" do
    owner     tomcat_user
    group     tomcat_user
    mode "0755"
    recursive true
  end


  # Create datasource-ovr file
  template "#{root_dir}/#{geostore_instance_name}/geostore-datasource-ovr.properties" do
    source "geostore/geostore-datasource-ovr.properties.erb"
    owner tomcat_user
    group tomcat_user
    mode "0644"
    variables(
      :database      => node['unredd-nfms-portal']['db_name'],
      :schema        => geostore_db_schema,
      :username      => geostore_db_user,
      :password      => geostore_db_pwd,
      :instance_name => geostore_instance_name
    )

    #action :create_if_missing
  end

  # Create init_users file
  template "#{root_dir}/#{geostore_instance_name}/init_users.xml" do
    source "geostore/init_users.xml.erb"
    owner tomcat_user
    group tomcat_user
    mode "0644"
    variables(
      :user     => params[:web_admin_user],
      :password => params[:web_admin_pwd]
    )
    #action :create_if_missing
  end

  # Create init_categories file
  template "#{root_dir}/#{geostore_instance_name}/init_categories.xml" do
    source "geostore/init_categories.xml.erb"
    owner tomcat_user
    group tomcat_user
    mode "0644"

    #action :create_if_missing
  end

  # Download and deploy GeoStore
  unredd_nfms_portal_app "#{geostore_instance_name}" do
    tomcat_instance tomcat_instance_name
    download_url    params[:download_url]
    user tomcat_user
  end
end



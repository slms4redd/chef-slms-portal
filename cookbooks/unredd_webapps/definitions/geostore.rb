define :geostore do
  include_recipe "unredd-apache"
  include_recipe "tomcat::base"
  include_recipe "unredd-db-conf"

  tomcat_user = node['tomcat']['user']

  # Download the GeoStore postgres schema file
  geostore_postgres_schema_file = '/tmp/002_create_schema_postgres.sql'
  geostore_postgres_schema_url  = 'https://raw.github.com/geosolutions-it/geostore/1.0.1/doc/sql/002_create_schema_postgres.sql'

  remote_file geostore_postgres_schema_file do
    source geostore_postgres_schema_url
    owner 'postgres'
    action :nothing
  end
  http_request "HEAD #{geostore_postgres_schema_url}" do
    message ""
    url geostore_postgres_schema_url
    action :head
    if ::File.exists?(geostore_postgres_schema_file)
      headers "If-Modified-Since" => ::File.mtime(geostore_postgres_schema_file).httpdate
    end
    notifies :create, resources(:remote_file => geostore_postgres_schema_file), :immediately
  end

  # Create stg_geostore user
  execute "create stg_geostore user" do
    user 'postgres'
    command <<-EOH
      echo "CREATE USER stg_geostore LOGIN PASSWORD 'admin'  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql
    EOH

    not_if 'psql -c "select * from pg_user where usename=\'stg_geostore\'" | grep -c stg_geostore', :user => 'postgres'
  end

  # Create stg_geostore database
  execute "create stg_geostore database" do
    user 'postgres'
    command "createdb -O stg_geostore stg_geostore"

    not_if 'psql -c "SELECT * from pg_database WHERE datname=\'stg_geostore\'" | grep -c stg_geostore', :user => 'postgres'
  end

  # Create the stg and diss geostore tables and sequences and change owner
  execute "configure postgis for stg_geostore" do
    user "postgres"
    # create the tables and sequences and change owner to stg_geostore
    command <<-EOH
      psql -f /tmp/002_create_schema_postgres.sql stg_geostore
      for tbl in `psql -qAt -c "select tablename from pg_tables where schemaname = 'public';" stg_geostore` ; do psql -c "alter table $tbl owner to stg_geostore" stg_geostore ; done
      for tbl in `psql -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = 'public';" stg_geostore` ; do psql -c "alter table $tbl owner to stg_geostore" stg_geostore ; done
      for tbl in `psql -qAt -c "select table_name from information_schema.views where table_schema = 'public';" stg_geostore` ; do psql -c "alter table $tbl owner to stg_geostore" stg_geostore ; done
    EOH
    
    #not_if 'blabla" | grep -c template_postgis', :user => 'postgres'
  end


  directory "/var/stg_geostore" do
    owner tomcat_user
    #group "tomcat6"
    mode "0755"
  end


  # Create datasource-ovr file for stg and diss geostore
  template "/var/stg_geostore/geostore-datasource-ovr.properties" do
    source "geostore-datasource-ovr.properties.erb"
    owner tomcat_user
    mode "0755"
    variables(
      :database      => 'stg_geostore',
      :username      => 'stg_geostore',
      :password      => 'stg_geostore',
      :instance_name => 'stg_geostore'
    )
    #action :create_if_missing
    #notifies :restart, "service[stg_geostore]", :delayed
  end

  # Create init_users file for stg and diss geostore
  template "/var/stg_geostore/init_users.xml" do
    source "init_users.xml.erb"
    owner tomcat_user
    mode "0755"
    variables(
      :user     => node['unredd_webapps']['stg_geostore']['web_admin_user'],
      :password => node['unredd_webapps']['stg_geostore']['web_admin_password']
    )
    #action :create_if_missing
    #notifies :restart, "service[stg_geostore]", :delayed
  end

  # Create init_categories file for stg and diss geostore
  template "/var/stg_geostore/init_categories.xml" do
    source "init_categories.xml.erb"
    owner tomcat_user
    mode "0755"
    #action :create_if_missing
    #notifies :restart, "service[stg_geostore]", :delayed
  end

  # Download GeoStore and deploy dissemination and staging instances
  unredd_webapps_app "stg_geostore" do
    tomcat_instance "stg_geostore"
    download_url "http://nfms4redd.org/downloads/geostore/nfms-geostore-1.0.1.zip"
    user tomcat_user
  end
end
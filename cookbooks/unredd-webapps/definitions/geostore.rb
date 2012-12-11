define :geostore do
  include_recipe "unredd-webapps::apache2-conf"
  include_recipe "tomcat::base"
  include_recipe "unredd-webapps::db-conf"

  tomcat_user = node['tomcat']['user']

  geostore_instance_name = params[:name]
  #geoserver_data_dir     = params[:data_dir]
  #geoserver_logs_dir     = params[:logs_dir]

  tomcat geostore_instance_name do
    user tomcat_user
    shutdown_port params[:tomcat_shutdown_port]
    ajp_port params[:tomcat_ajp_port]
    http_port params[:tomcat_http_port]
    jvm_opts [
      "-server",
      "-Xms#{params[:xms]}",
      "-Xmx#{params[:xmx]}",
      "-Dgeostore-ovr=#{node['unredd_webapps']['stg_geostore']['properties_ovr_file']}",
      "-Duser.timezone=GMT"
    ]
    manage_config_file true
  end

  # Configure postgis
  postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

  # CREATE USER stg_geostore LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
  # TODO: check that the following corresponds to the above
  postgresql_database_user geostore_instance_name do
    connection postgresql_connection_info
    password   'admin'
    action     :create
  end

  # createdb -O stg_geostore stg_geostore
  # TODO: check that the following corresponds to the above
  postgresql_database geostore_instance_name do
    connection postgresql_connection_info
    encoding   'DEFAULT'
    tablespace 'DEFAULT'
    owner      geostore_instance_name
    action     :create
    #connection_limit '-1'
  end



  # Download the geostore postgres schema file only if the remote source has changed (uses http_request resource)
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
  # Create the stg and diss geostore tables and sequences and change owner
  execute "configure geostore db" do
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
    owner     tomcat_user
    group     tomcat_user
    recursive true
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
    download_url    params[:download_url]
    user tomcat_user
  end
end



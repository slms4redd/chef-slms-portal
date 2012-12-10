action :install do
  tomcat_user = node['tomcat']['user']

  geoserver_instance_name = new_resource.instance_name
  geoserver_data_dir      = "/var/#{geoserver_instance_name}/data"
  geoserver_logs_dir      = "/var/#{geoserver_instance_name}/logs"

  tomcat "test" do
    user tomcat_user
    shutdown_port 8021
    ajp_port 8101
    http_port 8201
    jvm_opts [
      "-server",
      "-Xms#{node['unredd_webapps']['diss_geoserver']['jvm_opts']['xms']}",
      "-Xmx#{node['unredd_webapps']['diss_geoserver']['jvm_opts']['xmx']}",
      "-XX:MaxPermSize=128m",
      "-XX:PermSize=64m",
      "-XX:+UseConcMarkSweepGC",
      "-XX:NewSize=48m",
      "-Dorg.geotools.shapefile.datetime=true",
      "-DGEOSERVER_DATA_DIR=#{node['unredd_webapps']['diss_geoserver']['data_dir']}",
      "-DGEOSERVER_LOG_LOCATION=#{node['unredd_webapps']['diss_geoserver']['log_location']}",
      "-Duser.timezone=GMT"
    ]
    manage_config_file true
  end

  # # Create GeoServer data and log directories
  # directory "/var/#{geoserver_instance_name}" do
  #   owner tomcat_user
  #   group tomcat_user
  #   mode "0755"
  # end

  # # TODO: this doesn't set the correct users and groups
  # remote_directory geoserver_data_dir do
  #   source "geoserver_data_dir"
  #   files_owner tomcat_user
  #   #files_group tomcat_user
  #   #files_mode "0755"
  #   owner tomcat_user
  #   group tomcat_user
  #   mode "0755"
  #   not_if { ::File.exists?(geoserver_data_dir) }
  # end

  # directory geoserver_logs_dir do
  #   owner tomcat_user
  #   group tomcat_user
  # end

  # directory "/var/#{geoserver_instance_name}" do
  #   owner tomcat_user
  #   group tomcat_user
  #   mode "0755"
  # end


  # # Download GeoServer and deploy
  # # unredd_webapps_app geoserver_instance_name do
  # #   tomcat_instance geoserver_instance_name
  # #   download_url new_resource.download_url
  # #   user tomcat_user
  # # end


  # # Configure postgis
  # #Chef::Log.info "PASSWORD: #{node['postgresql']['password']['postgres']}" # DEBUG
  # postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

  # # CREATE USER diss_geoserver LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
  # postgresql_database_user geoserver_instance_name do
  #   connection postgresql_connection_info
  #   password 'admin'
  #   action :create
  # end

  # # createdb -O diss_geoserver -T template_postgis stg_geoserver
  # postgresql_database geoserver_instance_name do
  #   connection postgresql_connection_info
  #   template 'template_postgis'
  #   encoding 'DEFAULT'
  #   tablespace 'DEFAULT'
  #   #connection_limit '-1'
  #   owner geoserver_instance_name
  #   action :create
  # end
end

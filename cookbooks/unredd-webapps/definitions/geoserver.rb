define :geoserver do
  include_recipe "unredd-webapps::apache2-conf"
  include_recipe "tomcat::base"
  include_recipe "unredd-webapps::db-conf"

  tomcat_user = node['tomcat']['user']

  geoserver_instance_name = params[:name]
  geoserver_data_dir      = params[:data_dir]
  geoserver_logs_dir      = params[:logs_dir]

  tomcat geoserver_instance_name do
    user tomcat_user
    http_port     params[:tomcat_http_port]
    ajp_port      params[:tomcat_ajp_port]
    shutdown_port params[:tomcat_shutdown_port]
    jvm_opts [
      "-server",
      "-Xms#{params[:xms]}",
      "-Xmx#{params[:xmx]}",
      "-XX:MaxPermSize=128m",
      "-XX:PermSize=64m",
      "-XX:+UseConcMarkSweepGC",
      "-XX:NewSize=48m",
      "-Dorg.geotools.shapefile.datetime=true",
      "-DGEOSERVER_DATA_DIR=#{params[:data_dir]}",
      "-DGEOSERVER_LOG_LOCATION=#{params[:log_location]}",
      "-Duser.timezone=GMT"
    ]
    manage_config_file true
  end


  # Create GeoServer data and log directories

  remote_directory geoserver_data_dir do
    source      "geoserver_data_dir"
    files_owner tomcat_user
    #owner       tomcat_user
    #group       tomcat_user
    #mode        "644"
    #files_owner tomcat_user
    #files_group tomcat_user
    #files_mode  "755"

    not_if { ::File.exists?(geoserver_data_dir) }
  end

  # Permission of some directories are not set correcly by the remote_directory resource
  # so set them using chown/chmod
  execute "set data_dir permissions" do
    user "root"  
    command <<-EOH
      sudo chown -R #{tomcat_user}:#{tomcat_user} #{geoserver_data_dir}
      sudo chmod -R 755 #{geoserver_data_dir}
    EOH
  end

  directory geoserver_logs_dir do
    owner     tomcat_user
    group     tomcat_user
    recursive true
  end

  # Download and deploy GeoServer
  unredd_webapps_app geoserver_instance_name do
    tomcat_instance geoserver_instance_name
    download_url    params[:download_url]
    user            tomcat_user
  end


  # Configure postgis
  postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

  # CREATE USER diss_geoserver LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
  # TODO: check that the following corresponds to the above
  postgresql_database_user geoserver_instance_name do
    connection postgresql_connection_info
    password   'admin'
    action     :create
  end

  # createdb -O diss_geoserver -T template_postgis stg_geoserver
  # TODO: check that the following corresponds to the above
  postgresql_database geoserver_instance_name do
    connection postgresql_connection_info
    template   'template_postgis'
    encoding   'DEFAULT'
    tablespace 'DEFAULT'
    owner      geoserver_instance_name
    action     :create
    #connection_limit '-1'
  end
end
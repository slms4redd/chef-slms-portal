tomcat_user = node['tomcat']['user']

tomcat "stg_geostore" do
  user tomcat_user
  shutdown_port 8020
  ajp_port 8100
  http_port 8200
  jvm_opts [
    "-server",
    "-Xms#{node['unredd_webapps']['stg_geostore']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd_webapps']['stg_geostore']['jvm_opts']['xmx']}",
    "-Dgeostore-ovr=#{node['unredd_webapps']['stg_geostore']['properties_ovr_file']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end

tomcat "diss_geostore" do
  user tomcat_user
  shutdown_port 8024
  ajp_port 8104
  http_port 8204
  jvm_opts [
    "-server",
    "-Xms#{node['unredd_webapps']['diss_geostore']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd_webapps']['diss_geostore']['jvm_opts']['xmx']}",
    "-Dgeostore-ovr=#{node['unredd_webapps']['diss_geostore']['properties_ovr_file']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end

tomcat "stg_geoserver" do
  user tomcat_user
  shutdown_port 8021
  ajp_port 8101
  http_port 8201
  jvm_opts [
    "-server",
    "-Xms#{node['unredd_webapps']['stg_geoserver']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd_webapps']['stg_geoserver']['jvm_opts']['xmx']}",
    "-XX:MaxPermSize=128m",
    "-XX:PermSize=64m",
    "-XX:+UseConcMarkSweepGC",
    "-XX:NewSize=48m",
    "-Dorg.geotools.shapefile.datetime=true",
    "-DGEOSERVER_DATA_DIR=#{node['unredd_webapps']['stg_geoserver']['data_dir']}",
    "-DGEOSERVER_LOG_LOCATION=#{node['unredd_webapps']['stg_geoserver']['log_location']}",
    "-Duser.timezone=GMT",

    "-XX:+UseConcMarkSweepGC",
    "-XX:+CMSClassUnloadingEnabled",
    "-XX:+CMSClassUnloadingEnabled"
  ]
  manage_config_file true
end

tomcat "diss_geoserver" do
  user tomcat_user
  shutdown_port 8025
  ajp_port 8105
  http_port 8205
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
    "-Duser.timezone=GMT",

    "-XX:+UseConcMarkSweepGC",
    "-XX:+CMSClassUnloadingEnabled",
    "-XX:+CMSClassUnloadingEnabled"
  ]
  manage_config_file true
end

tomcat "stg_geobatch" do
  user tomcat_user
  shutdown_port 8022
  ajp_port 8102
  http_port 8202
  jvm_opts [
    "-server",
    "-Xms#{node['unredd_webapps']['stg_geobatch']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd_webapps']['stg_geobatch']['jvm_opts']['xmx']}",
    "-DGEOBATCH_CONFIG_DIR=#{node['unredd_webapps']['stg_geobatch']['config_dir']}",
    "-DGEOBATCH_TEMP_DIR=#{node['unredd_webapps']['stg_geobatch']['temp_dir']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end

tomcat "admin" do
  user tomcat_user
  shutdown_port 8023
  ajp_port 8103
  http_port 8203
  jvm_opts ["-server -Duser.timezone=GMT"]
  manage_config_file true
end

tomcat "portal" do
  user tomcat_user
  shutdown_port 8026
  ajp_port 8106
  http_port 8206
  jvm_opts ["-server",
    "-DPORTAL_CONFIG_DIR=#{node['unredd_webapps']['portal']['config_dir']}",
    "-DMINIFIED_JS=#{node['unredd_webapps']['portal']['mivnified_js']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end

geoserver "stg_geoserver" do
  download_url         "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  tomcat_instance_name 'stg_geoserver'
  tomcat_http_port     8201
  tomcat_ajp_port      8101
  tomcat_shutdown_port 8021
  data_dir             "/var/stg_geoserver/data"
  logs_dir             "/var/stg_geoserver/logs"
  db                   'stg_geoserver'
  db_user              'stg_geoserver'
  db_password          'admin'
  xms                  node['unredd_webapps']['stg_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['stg_geoserver']['jvm_opts']['xmx']
  data_dir             node['unredd_webapps']['stg_geoserver']['data_dir']
  log_location         node['unredd_webapps']['stg_geoserver']['log_location']
end

geoserver "diss_geoserver" do
  download_url         "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  tomcat_instance_name 'diss_geoserver'
  tomcat_http_port     8205
  tomcat_ajp_port      8105
  tomcat_shutdown_port 8025
  data_dir             "/var/diss_geoserver/data"
  logs_dir             "/var/diss_geoserver/logs"
  db                   'diss_geoserver'
  db_user              'diss_geoserver'
  db_password          'admin'
  xms                  node['unredd_webapps']['diss_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['diss_geoserver']['jvm_opts']['xmx']
  data_dir             node['unredd_webapps']['diss_geoserver']['data_dir']
  log_location         node['unredd_webapps']['diss_geoserver']['log_location']
end

# geostore "stg_geostore" do
#   download_url         "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
#   tomcat_http_port     8200
#   tomcat_ajp_port      8100
#   tomcat_shutdown_port 8020
#   xms                  node['unredd_webapps']['stg_geostore']['jvm_opts']['xms']
#   xmx                  node['unredd_webapps']['stg_geostore']['jvm_opts']['xmx']
# end

#include_recipe "unredd_webapps::deploy_geostores"

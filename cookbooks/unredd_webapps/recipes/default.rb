geoserver "stg_geoserver" do
  download_url  "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  tomcat_http_port     8201
  tomcat_ajp_port      8101
  tomcat_shutdown_port 8021
  data_dir             "/var/stg_geoserver/data"
  logs_dir             "/var/stg_geoserver/logs"
  xms                  node['unredd_webapps']['stg_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['stg_geoserver']['jvm_opts']['xmx']
  data_dir             node['unredd_webapps']['stg_geoserver']['data_dir']
  log_location         node['unredd_webapps']['stg_geoserver']['log_location']
end

geoserver "diss_geoserver" do
  download_url  "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  tomcat_http_port     8205
  tomcat_ajp_port      8105
  tomcat_shutdown_port 8025
  data_dir             "/var/diss_geoserver/data"
  logs_dir             "/var/diss_geoserver/logs"
  xms                  node['unredd_webapps']['diss_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['diss_geoserver']['jvm_opts']['xmx']
  data_dir             node['unredd_webapps']['diss_geoserver']['data_dir']
  log_location         node['unredd_webapps']['diss_geoserver']['log_location']
end
#include_recipe "unredd_webapps::deploy_geostores"

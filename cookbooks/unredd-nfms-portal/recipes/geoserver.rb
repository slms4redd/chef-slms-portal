#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: geoserver
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


geoserver "stg_geoserver" do
  download_url         node['unredd-nfms-portal']['geoserver_download_url']
  tomcat_instance_name node['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name']
  tomcat_http_port     node['unredd-nfms-portal']['stg_geoserver']['tomcat_http_port']
  tomcat_ajp_port      node['unredd-nfms-portal']['stg_geoserver']['tomcat_ajp_port']
  tomcat_shutdown_port node['unredd-nfms-portal']['stg_geoserver']['tomcat_shutdown_port']
  data_dir             node['unredd-nfms-portal']['stg_geoserver']['data_dir']
  log_location         node['unredd-nfms-portal']['stg_geoserver']['log_location']
  db_schema            node['unredd-nfms-portal']['stg_geoserver']['db_schema']
  db_user              node['unredd-nfms-portal']['stg_geoserver']['db_user']
  db_password          node['unredd-nfms-portal']['stg_geoserver']['db_password']
  xms                  node['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xmx']
  web_admin_password   node['unredd-nfms-portal']['stg_geoserver']['web_admin_password']
  web_admin_user       node['unredd-nfms-portal']['stg_geoserver']['web_admin_user']
  ext_data             node['unredd-nfms-portal']['stg_geoserver']['ext_data']
end

geoserver "diss_geoserver" do
  download_url         node['unredd-nfms-portal']['geoserver_download_url']
  tomcat_instance_name node['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name']
  tomcat_http_port     node['unredd-nfms-portal']['diss_geoserver']['tomcat_http_port']
  tomcat_ajp_port      node['unredd-nfms-portal']['diss_geoserver']['tomcat_ajp_port']
  tomcat_shutdown_port node['unredd-nfms-portal']['diss_geoserver']['tomcat_shutdown_port']
  data_dir             node['unredd-nfms-portal']['diss_geoserver']['data_dir']
  log_location         node['unredd-nfms-portal']['diss_geoserver']['log_location']
  db_schema            node['unredd-nfms-portal']['diss_geoserver']['db_schema']
  db_user              node['unredd-nfms-portal']['diss_geoserver']['db_user']
  db_password          node['unredd-nfms-portal']['diss_geoserver']['db_password']
  xms                  node['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xms']
  xmx                  node['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xmx']
  web_admin_password   node['unredd-nfms-portal']['diss_geoserver']['web_admin_password']
  web_admin_user       node['unredd-nfms-portal']['diss_geoserver']['web_admin_user']
  ext_data             node['unredd-nfms-portal']['diss_geoserver']['ext_data']
end

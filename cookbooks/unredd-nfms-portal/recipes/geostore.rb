#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: geostore
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


geostore "geostore" do
  download_url         node['unredd-nfms-portal']['geostore_download_url']
  root_dir             node['unredd-nfms-portal']['geostore']['root_dir']
  tomcat_instance_name node['unredd-nfms-portal']['geostore']['tomcat_instance_name']
  tomcat_http_port     node['unredd-nfms-portal']['geostore']['tomcat_http_port']
  tomcat_ajp_port      node['unredd-nfms-portal']['geostore']['tomcat_ajp_port']
  tomcat_shutdown_port node['unredd-nfms-portal']['geostore']['tomcat_shutdown_port']
  xms                  node['unredd-nfms-portal']['geostore']['jvm_opts']['xms']
  xmx                  node['unredd-nfms-portal']['geostore']['jvm_opts']['xmx']
  properties_ovr_file  node['unredd-nfms-portal']['geostore']['properties_ovr_file']
  web_admin_user       node['unredd-nfms-portal']['geostore']['web_admin_user']
  web_admin_pwd        node['unredd-nfms-portal']['geostore']['web_admin_password']
  db_schema            node['unredd-nfms-portal']['geostore']['db_schema']
  db_user              node['unredd-nfms-portal']['geostore']['db_user']
  db_password          node['unredd-nfms-portal']['geostore']['db_password']
  postgres_schema_url  node['unredd-nfms-portal']['geostore_schema_download_url']
end

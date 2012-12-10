# TODO: All this needs to be refactored but have to learn what's the best way to do it

tomcat_user = node['tomcat']['user']

require 'pathname'

#catalina_parent = Pathname.new(node['tomcat']['home']).parent.to_s

# Create GeoServer data and log directories
directory "/var/stg_geoserver" do
  owner tomcat_user
  #group "tomcat6"
  mode "0755"
end

# TODO: this doesn't set the correct users and groups
remote_directory "/var/stg_geoserver/data" do
  source "geoserver_data_dir"
  files_owner tomcat_user
  #files_group tomcat_user
  #files_mode "0755"
  owner tomcat_user
  group tomcat_user
  mode "0755"
  not_if { File.exists?("/var/stg_geoserver/data") }
end
directory "/var/stg_geoserver/logs" do
  owner tomcat_user
  #group "tomcat6"
end
directory "/var/diss_geoserver" do
  owner tomcat_user
  #group "tomcat6"
  mode "0755"
end
remote_directory "/var/diss_geoserver/data" do
  source "geoserver_data_dir"
  files_owner tomcat_user
  #files_group tomcat_user
  #files_mode "0755"
  owner tomcat_user
  group tomcat_user
  mode "0755"
  not_if { File.exists?("/var/diss_geoserver/data") }
end
directory "/var/diss_geoserver/logs" do
  owner tomcat_user
  #group "tomcat6"
  mode "0755"
end

# Download GeoServer and deploy dissemination and staging instances
unredd_webapps_app "diss_geoserver" do
  tomcat_instance "diss_geoserver"
  download_url "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  user tomcat_user
end

unredd_webapps_app "stg_geoserver" do
  tomcat_instance "stg_geoserver"
  download_url "http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war"
  user tomcat_user
end

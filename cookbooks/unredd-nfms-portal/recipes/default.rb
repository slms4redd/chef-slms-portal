# Install back-end
include_recipe "unredd-nfms-portal::apache2_conf"

include_recipe "unredd-nfms-portal::geoserver"
include_recipe "unredd-nfms-portal::geostore"
include_recipe "unredd-nfms-portal::geobatch"

stg_geoserver_tomcat  = node['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name']
diss_geoserver_tomcat = node['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name']

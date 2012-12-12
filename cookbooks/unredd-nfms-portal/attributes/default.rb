default['unredd-nfms-portal']['geoserver_download_url']       = 'http://nfms4redd.org/downloads/geoserver/geoserver-2.2+gdal+pyramid+flow.war'
default['unredd-nfms-portal']['geostore_download_url']        = 'http://nfms4redd.org/downloads/geostore/nfms-geostore-1.0.1.war'
default['unredd-nfms-portal']['geostore_schema_download_url'] = 'https://raw.github.com/geosolutions-it/geostore/1.0.1/doc/sql/002_create_schema_postgres.sql'


default['unredd-nfms-portal']['stg_geostore']['root_dir'] = '/var'
default['unredd-nfms-portal']['stg_geostore']['tomcat_instance_name'] = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['tomcat_http_port']     = 8200
default['unredd-nfms-portal']['stg_geostore']['tomcat_ajp_port']      = 8100
default['unredd-nfms-portal']['stg_geostore']['tomcat_shutdown_port'] = 8020
default['unredd-nfms-portal']['stg_geostore']['db']                   = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['db_user']              = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['db_password']          = 'admin'
default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xms']      = '512m'
default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xmx']      = '512m'
#default['unredd-nfms-portal']['stg_geostore']['properties_ovr_file']  = 'file:/var/stg_geostore/geostore-datasource-ovr.properties'
default['unredd-nfms-portal']['stg_geostore']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['stg_geostore']['web_admin_password']   = 'admin'

default['unredd-nfms-portal']['diss_geostore']['root_dir'] = '/var'
default['unredd-nfms-portal']['diss_geostore']['tomcat_instance_name'] = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['tomcat_http_port']     = 8204
default['unredd-nfms-portal']['diss_geostore']['tomcat_ajp_port']      = 8104
default['unredd-nfms-portal']['diss_geostore']['tomcat_shutdown_port'] = 8024
default['unredd-nfms-portal']['diss_geostore']['db']                   = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['db_user']              = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['db_password']          = 'admin'
default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xms']      = '512m'
default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xmx']      = '1024m'
#default['unredd-nfms-portal']['diss_geostore']['properties_ovr_file']  = 'file:/var/diss_geostore/geostore-datasource-ovr.properties'
default['unredd-nfms-portal']['diss_geostore']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['diss_geostore']['web_admin_password']   = 'admin'


default['unredd-nfms-portal']['stg_geoserver']['root_dir'] = '/var'
default['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name'] = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['tomcat_http_port']     = 8201
default['unredd-nfms-portal']['stg_geoserver']['tomcat_ajp_port']      = 8101
default['unredd-nfms-portal']['stg_geoserver']['tomcat_shutdown_port'] = 8021
default['unredd-nfms-portal']['stg_geoserver']['db']                   = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['db_user']              = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['db_password']          = 'admin'
default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xms']      = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xmx']      = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['data_dir']             = '/var/stg_geoserver/data'
default['unredd-nfms-portal']['stg_geoserver']['log_location']         = '/var/stg_geoserver/logs/geoserver.log'

default['unredd-nfms-portal']['diss_geoserver']['root_dir'] = '/var'
default['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name'] = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['tomcat_http_port']     = 8205
default['unredd-nfms-portal']['diss_geoserver']['tomcat_ajp_port']      = 8105
default['unredd-nfms-portal']['diss_geoserver']['tomcat_shutdown_port'] = 8025
default['unredd-nfms-portal']['diss_geoserver']['db']                   = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['db_user']              = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['db_password']          = 'admin'
default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xms']      = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xmx']      = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['data_dir']             = '/var/diss_geoserver/data'
default['unredd-nfms-portal']['diss_geoserver']['log_location']         = '/var/diss_geoserver/logs/geoserver.log'


default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xms'] = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xmx'] = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['config_dir']      = '/var/stg_geobatch/config'
default['unredd-nfms-portal']['stg_geobatch']['temp_dir']        = '/var/stg_geobatch/temp'


default['unredd-nfms-portal']['portal']['config_dir']  = '/var/portal/'
default['unredd-nfms-portal']['portal']['minified_js'] = true

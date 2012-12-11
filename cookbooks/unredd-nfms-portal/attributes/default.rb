default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xms']     = '512m'
default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xmx']     = '512m'
default['unredd-nfms-portal']['stg_geostore']['properties_ovr_file'] = 'file:/var/stg_geostore/geostore-datasource-ovr.properties'
default['unredd-nfms-portal']['stg_geostore']['web_admin_user']      = 'admin'
default['unredd-nfms-portal']['stg_geostore']['web_admin_password']  = 'admin'

default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xms']     = '512m'
default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xmx']     = '1024m'
default['unredd-nfms-portal']['diss_geostore']['properties_ovr_file'] = 'file:/var/diss_geostore/geostore-datasource-ovr.properties'
default['unredd-nfms-portal']['diss_geostore']['web_admin_user']      = 'admin'
default['unredd-nfms-portal']['diss_geostore']['web_admin_password']  = 'admin'

default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xms'] = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xmx'] = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['data_dir']        = '/var/stg_geoserver/data'
default['unredd-nfms-portal']['stg_geoserver']['log_location']    = '/var/stg_geoserver/logs/geoserver.log'

default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xms'] = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xmx'] = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['data_dir']        = '/var/diss_geoserver/data'
default['unredd-nfms-portal']['diss_geoserver']['log_location']    = '/var/diss_geoserver/logs/geoserver.log'

default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xms'] = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xmx'] = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['config_dir']      = '/var/stg_geobatch/config'
default['unredd-nfms-portal']['stg_geobatch']['temp_dir']        = '/var/stg_geobatch/temp'

default['unredd-nfms-portal']['portal']['config_dir']  = '/var/portal/'
default['unredd-nfms-portal']['portal']['minified_js'] = true

default['unredd_webapps']['stg_geostore']['jvm_opts']['xms']     = '512m'
default['unredd_webapps']['stg_geostore']['jvm_opts']['xmx']     = '512m'
default['unredd_webapps']['stg_geostore']['properties_ovr_file'] = '/var/stg_geostore/geostore-datasource-ovr.properties'
default['unredd_webapps']['stg_geostore']['web_admin_user']      = 'admin'
default['unredd_webapps']['stg_geostore']['web_admin_password']  = 'admin'

default['unredd_webapps']['diss_geostore']['jvm_opts']['xms']     = '512m'
default['unredd_webapps']['diss_geostore']['jvm_opts']['xmx']     = '1024m'
default['unredd_webapps']['diss_geostore']['properties_ovr_file'] = 'file:/var/diss_geostore/geostore-datasource-ovr.properties'
default['unredd_webapps']['diss_geostore']['web_admin_user']      = 'admin'
default['unredd_webapps']['diss_geostore']['web_admin_password']  = 'admin'

default['unredd_webapps']['stg_geoserver']['jvm_opts']['xms'] = '1024m'
default['unredd_webapps']['stg_geoserver']['jvm_opts']['xmx'] = '1024m'
default['unredd_webapps']['stg_geoserver']['data_dir']        = '/var/stg_geoserver/data'
default['unredd_webapps']['stg_geoserver']['log_location']    = '/var/stg_geoserver/logs/geoserver.log'

default['unredd_webapps']['diss_geoserver']['jvm_opts']['xms'] = '1024m'
default['unredd_webapps']['diss_geoserver']['jvm_opts']['xmx'] = '1024m'
default['unredd_webapps']['diss_geoserver']['data_dir']        = '/var/diss_geoserver/data'
default['unredd_webapps']['diss_geoserver']['log_location']    = '/var/diss_geoserver/logs/geoserver.log'

default['unredd_webapps']['stg_geobatch']['jvm_opts']['xms'] = '2048m'
default['unredd_webapps']['stg_geobatch']['jvm_opts']['xmx'] = '2048m'
default['unredd_webapps']['stg_geobatch']['config_dir']      = '/var/stg_geobatch/config'
default['unredd_webapps']['stg_geobatch']['temp_dir']        = '/var/stg_geobatch/temp'

default['unredd_webapps']['portal']['config_dir']  = '/var/portal/'
default['unredd_webapps']['portal']['minified_js'] = true

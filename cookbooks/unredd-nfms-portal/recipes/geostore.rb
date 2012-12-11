geostore "stg_geostore" do
  download_url         "http://nfms4redd.org/downloads/geostore/nfms-geostore-1.0.1.war"
  tomcat_instance_name 'stg_geostore'
  tomcat_http_port     8200
  tomcat_ajp_port      8100
  tomcat_shutdown_port 8020
  xms                  node['unredd_webapps']['stg_geostore']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['stg_geostore']['jvm_opts']['xmx']
  properties_ovr_file  node['unredd_webapps']['stg_geostore']['properties_ovr_file']
  web_amin_user        node['unredd_webapps']['stg_geostore']['web_admin_user']
  web_amin_pwd         node['unredd_webapps']['stg_geostore']['web_admin_password']
  db                   'stg_geostore'
  db_user              'stg_geostore'
  db_password          'admin'
  postgres_schema_file '/tmp/002_create_schema_postgres.sql'
  postgres_schema_url  'https://raw.github.com/geosolutions-it/geostore/1.0.1/doc/sql/002_create_schema_postgres.sql'
end

geostore "diss_geostore" do
  download_url         "http://nfms4redd.org/downloads/geostore/nfms-geostore-1.0.1.war"
  tomcat_instance_name 'diss_geostore'
  tomcat_http_port     8204
  tomcat_ajp_port      8104
  tomcat_shutdown_port 8024
  xms                  node['unredd_webapps']['diss_geostore']['jvm_opts']['xms']
  xmx                  node['unredd_webapps']['diss_geostore']['jvm_opts']['xmx']
  properties_ovr_file  node['unredd_webapps']['diss_geostore']['properties_ovr_file']
  web_amin_user        node['unredd_webapps']['diss_geostore']['web_admin_user']
  web_amin_pwd         node['unredd_webapps']['diss_geostore']['web_admin_password']
  db                   'diss_geostore'
  db_user              'diss_geostore'
  db_password          'admin'
  postgres_schema_file '/tmp/002_create_schema_postgres.sql'
  postgres_schema_url  'https://raw.github.com/geosolutions-it/geostore/1.0.1/doc/sql/002_create_schema_postgres.sql'
end

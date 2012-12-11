# This is a stub

tomcat_user = node['tomcat']['user']

tomcat "portal" do
  user tomcat_user
  shutdown_port 8026
  ajp_port 8106
  http_port 8206
  jvm_opts ["-server",
    "-DPORTAL_CONFIG_DIR=#{node['unredd_webapps']['portal']['config_dir']}",
    "-DMINIFIED_JS=#{node['unredd_webapps']['portal']['mivnified_js']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end

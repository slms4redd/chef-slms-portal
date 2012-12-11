# This is a stub

tomcat_user = node['tomcat']['user']

tomcat "admin" do
  user tomcat_user
  shutdown_port 8023
  ajp_port 8103
  http_port 8203
  jvm_opts ["-server -Duser.timezone=GMT"]
  manage_config_file true
end

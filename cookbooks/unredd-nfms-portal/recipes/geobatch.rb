# This is a stub

tomcat_user = node['tomcat']['user']

tomcat "stg_geobatch" do
  user tomcat_user
  shutdown_port 8022
  ajp_port 8102
  http_port 8202
  jvm_opts [
    "-server",
    "-Xms#{node['unredd_webapps']['stg_geobatch']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd_webapps']['stg_geobatch']['jvm_opts']['xmx']}",
    "-DGEOBATCH_CONFIG_DIR=#{node['unredd_webapps']['stg_geobatch']['config_dir']}",
    "-DGEOBATCH_TEMP_DIR=#{node['unredd_webapps']['stg_geobatch']['temp_dir']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end



remote_directory "/var/stg_geobatch" do
  source      "geobatch_dir"
  files_owner tomcat_user

  not_if { ::File.exists?("/var/stg_geobatch") }

  #notifies :run, resources(:execute => "set data_dir permissions")
end

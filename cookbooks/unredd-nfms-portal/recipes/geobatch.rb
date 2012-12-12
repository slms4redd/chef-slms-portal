tomcat_user = node['tomcat']['user']
geobatch_base = "/var/stg_geobatch"
geobatch_parent = Pathname.new(geobatch_base).parent.to_s



directory geobatch_parent do
  owner tomcat_user
  group tomcat_user
  mode 0775
  action :create
end

# Permission of some directories are not set correctly by the remote_directory resource
# so set them using chown/chmod
execute "set #{geobatch_base} permissions" do
  user "root"  
  command <<-EOH
    chown -R #{tomcat_user}:#{tomcat_user} #{geobatch_base}
    find #{geobatch_base} -type d -exec chmod 755 {} \\;
    find #{geobatch_base} -type f -exec chmod 644 {} \\;
  EOH

  action :nothing
end

remote_directory geobatch_base do
  source      "geobatch_dir"
  overwrite false
  purge false
  notifies :run, resources(:execute => "set #{geobatch_base} permissions")

  not_if { ::File.exists?("/var/stg_geobatch") }
end

template "#{geobatch_base}/config/ingestionFlow.xml" do
  source "geobatch/ingestionFlow.xml.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
  variables(
    :ingestion_input_dir           => "#{geobatch_base}/input/ingest",
    :ingestion_config_override_dir => "#{geobatch_base}/config/ingestionFlow",
    :original_data_dir             => "#{geobatch_base}/orig",
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
    :XXX => XXX,
  )
  if ::File.exists?("#{node['apache']['dir']}/sites-enabled/#{application_name}.conf")
    notifies :reload, resources(:service => "apache2"), :delayed
  end
end



# tomcat "stg_geobatch" do
#   user tomcat_user
#   shutdown_port 8022
#   ajp_port 8102
#   http_port 8202
#   jvm_opts [
#     "-server",
#     "-Xms#{node['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xms']}",
#     "-Xmx#{node['unredd-nfms-portal']['unredd-nfms-portal']['jvm_opts']['xmx']}",
#     "-DGEOBATCH_CONFIG_DIR=#{node['unredd-nfms-portal']['stg_geobatch']['config_dir']}",
#     "-DGEOBATCH_TEMP_DIR=#{node['unredd-nfms-portal']['stg_geobatch']['temp_dir']}",
#     "-Duser.timezone=GMT"
#   ]
#   manage_config_file true
# end




# directory geobatch_base do
#   owner tomcat_user
#   group tomcat_user
#   mode 0775
#   action :create
# end

# %w{ config input orig temp }.each do |dir|
#   directory "#{geobatch_base.base}/#{dir}" do
#     owner tomcat_user
#     group tomcat_user
#     recursive true
#     mode 0775
#     action :create
#   end
# end















#   # don't have a need yet to template these files
#   %w{ catalina.policy catalina.properties logging.properties context.xml tomcat-users.xml }.each do |tc_file|
#     cookbook_file "#{new_resource.base}/conf/#{tc_file}" do
#       cookbook "tomcat"
#       source tc_file
#       mode "0775"
#       owner new_resource.user
#       group new_resource.user
#       action :create
#     end
#   end

#   template "#{new_resource.base}/conf/web.xml" do
#     cookbook "tomcat"
#     source "web.xml.erb"
#     owner new_resource.user
#     group new_resource.user
#     mode "0774"
#     variables( :session_timeout => new_resource.session_timeout )
#     action :create
#   end  

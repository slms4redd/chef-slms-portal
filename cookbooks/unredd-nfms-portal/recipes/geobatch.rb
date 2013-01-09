#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: geobatch
#
# (C) 2013, FAO Forestry Department (http://www.fao.org/forestry/)
#
# This application is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation;
# version 3.0 of the License.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.


tomcat_user       = node['tomcat']['user']
geobatch_root_dir = node['unredd-nfms-portal']['stg_geobatch']['root_dir']
geobatch_parent   = Pathname.new(geobatch_root_dir).parent.to_s


directory geobatch_parent do
  owner tomcat_user
  group tomcat_user
  mode 0775
  action :create
end

remote_directory geobatch_root_dir do
  source "geobatch_dir"
  overwrite false
  purge false
  #notifies :run, resources(:execute => "set #{geobatch_root_dir} permissions")

  not_if { ::File.exists?("/var/stg_geobatch") }
end

# Permission of some directories are not set correctly by the remote_directory resource
# so set them using chown/chmod
execute "set #{geobatch_root_dir} permissions" do
  user "root"
  command <<-EOH
    chown -R #{tomcat_user}:#{tomcat_user} #{geobatch_root_dir}
    find #{geobatch_root_dir} -type d -exec chmod 755 {} \\;
    find #{geobatch_root_dir} -type f -exec chmod 644 {} \\;
  EOH

  #action :nothing
end

# GeoBatch flows config
# TODO: some params are still hard coded
template "#{geobatch_root_dir}/config/ingestionFlow.xml" do
  source "geobatch/ingestionFlow.xml.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
end

template "#{geobatch_root_dir}/config/publishingFlow.xml" do
  source "geobatch/publishingFlow.xml.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
end

template "#{geobatch_root_dir}/config/reprocessFlow.xml" do
  source "geobatch/reprocessFlow.xml.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
end

# Install tomcat instance
tomcat "stg_geobatch" do
  user tomcat_user
  shutdown_port 8022
  ajp_port 8102
  http_port 8202
  jvm_opts [
    "-server",
    "-Xms#{node['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xms']}",
    "-Xmx#{node['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xmx']}",
    "-DGEOBATCH_CONFIG_DIR=#{node['unredd-nfms-portal']['stg_geobatch']['config_dir']}",
    "-DGEOBATCH_TEMP_DIR=#{node['unredd-nfms-portal']['stg_geobatch']['temp_dir']}",
    "-Duser.timezone=GMT"
  ]
  manage_config_file true
end


# Download and deploy GeoStore
unredd_nfms_portal_app "stg_geobatch" do
  tomcat_instance "stg_geobatch"
  download_url    "http://nfms4redd.org/downloads/geobatch/nfms-geobatch-1.0-RC1.war"
  user tomcat_user
end

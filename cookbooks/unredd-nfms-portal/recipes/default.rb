#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: default
#
# (C) 2012, FAO Forestry Department (http://www.fao.org/forestry/)
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


# Install back-end
include_recipe "unredd-nfms-portal::apache2_conf"

include_recipe "unredd-nfms-portal::jai"

include_recipe "unredd-nfms-portal::geoserver"
include_recipe "unredd-nfms-portal::geostore"
include_recipe "unredd-nfms-portal::geobatch"

tomcat_user = node['tomcat']['user']


# Install the portal front end

diss_geoserver_tomcat = node['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name']

# Reopen the diss_geoserver tomcat resource and add portal jvm options
t = resources(:tomcat => "diss_geoserver")
t.jvm_opts += [
  "-DPORTAL_CONFIG_DIR=#{node['unredd-nfms-portal']['portal']['config_dir']}",
  "-DMINIFIED_JS=#{node['unredd-nfms-portal']['portal']['minified_js']}"
  # "-Duser.timezone=GMT" # this has already been set
]

portal_config_dir = node['unredd-nfms-portal']['portal']['config_dir']

remote_directory portal_config_dir do
  source "portal_config_dir"
  overwrite false
  purge false
  #notifies :run, resources(:execute => "set #{geobatch_root_dir} permissions")

  not_if { ::File.exists?("#{portal_config_dir}") }
end

# Permission of some directories are not set correctly by the remote_directory resource
# so set them using chown/chmod
execute "set #{portal_config_dir} permissions" do
  user "root"
  command <<-EOH
    chown -R #{tomcat_user}:#{tomcat_user} #{portal_config_dir}
    find #{portal_config_dir} -type d -exec chmod 755 {} \\;
    find #{portal_config_dir} -type f -exec chmod 644 {} \\;
  EOH

  #action :nothing
end

unredd_nfms_portal_app "portal" do
  tomcat_instance diss_geoserver_tomcat
  download_url    "http://nfms4redd.org/downloads/portal/portal-0.9.1.war"
  user            tomcat_user
end

template "#{portal_config_dir}/portal.properties" do
  source "portal/portal.properties.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
end


# Install the admin ui
# Since we need to modify unredd_admin_applicationContext.xml and security.xml and
# the configuration directory can't be moved yet outside of the webapps directory,
# we manually expand the war and copy the full webapp dir into tomcat

catalina_parent = Pathname.new(node['tomcat']['home']).parent.to_s
stg_geoserver_tomcat  = node['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name']

admin_download_url= "http://nfms4redd.org/downloads/admin/admin-0.6.war"
admin_file_name = admin_download_url.split('/')[-1]
# admin_base = "#{catalina_parent}/#{tomcat_instance}"

# Reopen the stg_geoserver tomcat resource and add admin ui jvm options
t = resources(:tomcat => "stg_geoserver")
# t.jvm_opts += ["-server -Duser.timezone=GMT"] # already set

# Download the file only if the remote source has changed (uses http_request resource)
remote_file "/var/tmp/#{admin_file_name}" do
  source admin_download_url
  owner tomcat_user
  action :nothing
end
http_request "HEAD #{admin_download_url}" do
  message ""
  url admin_download_url
  action :head
  if ::File.exists?("/var/tmp/#{admin_file_name}")
    headers "If-Modified-Since" => ::File.mtime("/var/tmp/#{admin_file_name}").httpdate
  end
  notifies :create, resources(:remote_file => "/var/tmp/#{admin_file_name}"), :immediately
end

execute "unzip admin ui war" do
  command <<-EOH
    unzip /var/tmp/#{admin_file_name} -d /var/tmp/admin
    chown -R #{tomcat_user}: /var/tmp/admin
    chmod 755 /var/tmp/admin
    find /var/tmp/admin -type d -exec chmod 755 {} \\;
    find /var/tmp/admin -type f -exec chmod 644 {} \\;
  EOH
  action :run
end

template "/var/tmp/admin/WEB-INF/unredd_admin_applicationContext.xml" do
  source "admin/unredd_admin_applicationContext.xml.erb"
  owner tomcat_user
  group tomcat_user
  mode 0644
end

template "/var/tmp/admin/WEB-INF/security.xml" do
  source "admin/security.xml.erb"
  owner tomcat_user
  group tomcat_user

  variables({
    :md5_encoded_password => ::Digest::MD5.hexdigest(node['unredd-nfms-portal']['admin']['password'])
  })


  mode 0644
end

execute "deploy admin ui" do
  command <<-EOH
    cp -R /var/tmp/admin #{catalina_parent}/#{stg_geoserver_tomcat}/webapps
  EOH
  action :run
end

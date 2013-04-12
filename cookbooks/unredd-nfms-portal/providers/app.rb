#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Provider:: app
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


# The app resource downloads a war from the web and deploys it in a given directory

# TODO: check if the version is new and deploy only in that case

action :install do
  file_name = new_resource.download_url.split('/')[-1]

  #Chef::Log.info "#{new_resource.base}/#{new_resource.app_name}/webapps/#{new_resource.app_name}.war" # DEBUG

  # Download the file only if the remote source has changed (uses http_request resource)
  remote_file "#{Chef::Config[:file_cache_path]}/#{file_name}" do
    source new_resource.download_url
    owner new_resource.user
    retries 10
    retry_delay 60
    action :nothing
  end
  http_request "HEAD #{new_resource.download_url}" do
    message ""
    url new_resource.download_url
    action :head
    if ::File.exists?("#{Chef::Config[:file_cache_path]}/#{file_name}")
      headers "If-Modified-Since" => ::File.mtime("#{Chef::Config[:file_cache_path]}/#{file_name}").httpdate
    end
    retries 10
    retry_delay 60
    notifies :create, resources(:remote_file => "#{Chef::Config[:file_cache_path]}/#{file_name}"), :immediately
  end

  # TODO: The app is deployed every time Chef runs, even if there's no chance - check for changes
  execute "deploy #{file_name}" do
    destination = ::File.join(new_resource.base, new_resource.tomcat_instance, 'webapps', "#{new_resource.app_name}.war")
    command <<-EOH
      install -o #{new_resource.user} -g #{new_resource.user} #{Chef::Config[:file_cache_path]}/#{file_name} #{destination}
    EOH
    action :run
  end
end

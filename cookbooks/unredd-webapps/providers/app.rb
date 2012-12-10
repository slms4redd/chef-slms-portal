# The app resource downloads a war from the web and deploys it in a given directory

# TODO: check if the version is new and deploy only in that case

action :install do
  file_name = new_resource.download_url.split('/')[-1]

  #Chef::Log.info "#{new_resource.base}/#{new_resource.app_name}/webapps/#{new_resource.app_name}.war" # DEBUG

  # Download the file only if the remote source has changed (uses http_request resource)
  remote_file "/tmp/#{file_name}" do
    source new_resource.download_url
    owner new_resource.user
    action :nothing
  end


  http_request "HEAD #{new_resource.download_url}" do
    message ""
    url new_resource.download_url
    action :head
    if ::File.exists?("/tmp/#{file_name}")
      headers "If-Modified-Since" => ::File.mtime("/tmp/#{file_name}").httpdate
    end
    notifies :create, resources(:remote_file => "/tmp/#{file_name}"), :immediately
  end

  # TODO: The app is deployed every time Chef runs, even if there's no chance - check for changes
  execute "deploy" do
    user new_resource.user
    #Chef::Log.info "#{new_resource.base}/#{new_resource.app_name}/webapps/#{new_resource.app_name}.war" # DEBUG
    command <<-EOH
      cp /tmp/#{file_name} #{new_resource.base}/#{new_resource.app_name}/webapps/#{new_resource.app_name}.war
    EOH
    # cp /tmp/#{file_name} /var/tomcat/diss_geoserver/webapps/diss_geoserver.war
    #command "cp /tmp/geoserver.zip /var/tomcat/diss_geoserver/webapps"

    action :run
  end
end

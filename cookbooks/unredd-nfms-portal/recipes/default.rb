# Install back-end
include_recipe "unredd-nfms-portal::apache2_conf"

include_recipe "unredd-nfms-portal::geoserver"
include_recipe "unredd-nfms-portal::geostore"
include_recipe "unredd-nfms-portal::geobatch"

stg_geoserver_tomcat  = node['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name']
diss_geoserver_tomcat = node['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name']

# # Install admin ui
# unredd_nfms_portal_app "admin" do
#   tomcat_instance stg_geoserver_tomcat
#   download_url    "http://nfms4redd.org/downloads/admin/admin-0.6.war"
#   user            node['tomcat']['user']
# end

# catalina_parent = Pathname.new(node['tomcat']['home']).parent.to_s

# template "#{catalina_parent}/#{stg_geoserver_tomcat}/webapps/admin/WEB-INF/unredd_admin_applicationContext.xml" do
#   source "admin/unredd_admin_applicationContext.xml.erb"
#   owner node['tomcat']['user']
#   group node['tomcat']['user']
#   mode 0644
# end






# catalina_parent = Pathname.new(node['tomcat']['home']).parent.to_s

# admin_download_url= "http://nfms4redd.org/downloads/admin/admin-0.6.war"
# admin_file_name = admin_download_url.split('/')[-1]
# admin_base = "#{catalina_parent}/#{tomcat_instance}"

# # Download the file only if the remote source has changed (uses http_request resource)
# remote_file "/var/tmp/#{file_name}" do
#   source admin_download_url
#   owner node['tomcat']['user']
#   action :nothing
# end
# http_request "HEAD #{admin_download_url}" do
#   message ""
#   url admin_download_url
#   action :head
#   if ::File.exists?("/var/tmp/#{admin_file_name}")
#     headers "If-Modified-Since" => ::File.mtime("/var/tmp/#{admin_file_name}").httpdate
#   end
#   notifies :create, resources(:remote_file => "/var/tmp/#{admin_file_name}"), :immediately
# end

# # TODO: The app is deployed every time Chef runs, even if there's no chance - check for changes
# execute "deploy" do
#   user node['tomcat']['user']
#   destination = ::File.join(new_resource.base, new_resource.tomcat_instance, 'webapps', "#{new_resource.app_name}.war")
#   command <<-EOH
#     cp /var/tmp/#{admin_file_name} #{destination}
#   EOH
#   action :run
# end




# # Install portal
# unredd_nfms_portal_app "portal" do
#   tomcat_instance diss_geoserver_tomcat
#   download_url    "http://nfms4redd.org/downloads/portal/portal-0.9.1.war"
#   user            node['tomcat']['user']
# end

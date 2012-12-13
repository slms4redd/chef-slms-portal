include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_ajp"

# configure mod_proxy
template "#{node['apache']['dir']}/mods-available/proxy.conf" do
  source "proxy.conf.erb"
  notifies :restart, "service[apache2]", :delayed
  mode 0644
end

web_app "tomcat_proxy" do
  template "unredd_proxy_template.conf.erb"
  owner "apache"
  notifies :restart, "service[apache2]", :delayed
  #mode 0750
end

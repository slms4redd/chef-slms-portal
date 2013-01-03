include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_ajp"

# configure mod_proxy
template "#{node['apache']['dir']}/mods-available/proxy.conf" do
  source "proxy.conf.erb"
  mode 0644

  notifies :restart, "service[apache2]", :delayed
end

template "#{node['apache']['dir']}/sites-enabled/unredd.conf" do
  source "unredd.conf.erb"
  variables({
    :stg_geostore_ajp_porty   => node['unredd-nfms-portal']['stg_geostore']['tomcat_ajp_port'],
    :stg_geoserver_ajp_porty  => node['unredd-nfms-portal']['stg_geoserver']['tomcat_ajp_port'],
    :stg_geobatch_ajp_porty   => node['unredd-nfms-portal']['stg_geobatch']['tomcat_ajp_port'],
    :admin_ajp_porty          => node['unredd-nfms-portal']['stg_geoserver']['tomcat_ajp_port'],
    :diss_geostore_ajp_porty  => node['unredd-nfms-portal']['diss_geostore']['tomcat_ajp_port'],
    :diss_geoserver_ajp_porty => node['unredd-nfms-portal']['diss_geoserver']['tomcat_ajp_port'],
    :portal_ajp_porty         => node['unredd-nfms-portal']['diss_geoserver']['tomcat_ajp_port']
  })
  mode 0644

  notifies :restart, "service[apache2]", :delayed
end

#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: apache2_conf
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

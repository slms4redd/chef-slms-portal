#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: install_test_data
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


cookbook_file "/var/tmp/sample_data.tgz" do
  source "sample_data.tgz"
  mode 00644
end

cookbook_file "/var/tmp/unredd_geostore_backup.xml" do
  source "unredd_geostore_backup.xml"
  owner node['tomcat']['user']
  group node['tomcat']['user']
  mode 00666
end

execute "uncompress sample data" do
  user "root"
  command <<-EOH
    cd /var/tmp/
    tar -xf sample_data.tgz

    mkdir -p  /var/stg_geoserver/extdata/stats/
    cp drc/stats/* /var/stg_geoserver/extdata/stats/
    cp -R drc/forest_mask_mosaic /var/stg_geoserver/extdata

    mkdir -p  /var/diss_geoserver/extdata/
    cp -R drc/forest_mask_mosaic /var/diss_geoserver/extdata
  EOH
end

template "/var/stg_geoserver/extdata/forest_mask_mosaic/datastore.properties" do
  source "test_data/datastore.properties.erb"
  owner  node['tomcat']['user']
  group  node['tomcat']['user']
  variables(
    :db          => node['unredd-nfms-portal']['stg_geoserver']['db'],
    :db_user     => node['unredd-nfms-portal']['stg_geoserver']['db_user'],
    :db_password => node['unredd-nfms-portal']['stg_geoserver']['db_password']
  )
  mode 0644
end

template "/var/diss_geoserver/extdata/forest_mask_mosaic/datastore.properties" do
  source "test_data/datastore.properties.erb"
  owner  node['tomcat']['user']
  group  node['tomcat']['user']
  variables(
    :db          => node['unredd-nfms-portal']['diss_geoserver']['db'],
    :db_user     => node['unredd-nfms-portal']['diss_geoserver']['db_user'],
    :db_password => node['unredd-nfms-portal']['diss_geoserver']['db_password']
  )
  mode 0644
end

template "#{node['unredd-nfms-portal']['portal']['config_dir']}/static/custom.js" do
  source "test_data/custom.js.erb"
  owner  node['tomcat']['user']
  group  node['tomcat']['user']
  mode 0644
end

template "#{node['unredd-nfms-portal']['portal']['config_dir']}/layers.json" do
  source "test_data/layers.json.erb"
  owner  node['tomcat']['user']
  group  node['tomcat']['user']
  mode 0644
end

execute "set stg and diss geoserver extdata dir permissions" do
  user "root"
  command <<-EOH
    chown -R #{node['tomcat']['user']}: /var/stg_geoserver/extdata
    find /var/stg_geoserver/extdata -type d -exec chmod 755 {} \\;
    find /var/stg_geoserver/extdata -type f -exec chmod 644 {} \\;

    chown -R #{node['tomcat']['user']}: /var/diss_geoserver/extdata
    find /var/diss_geoserver/extdata -type d -exec chmod 755 {} \\;
    find /var/diss_geoserver/extdata -type f -exec chmod 644 {} \\;
  EOH
end

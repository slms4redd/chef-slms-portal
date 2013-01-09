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

    cp -R drc/diss_forest_mask_mosaic /var/stg_geoserver/extdata/forest_mask_mosaic
    #curl -u admin:admin -XPUT -H "Content-type: text/xml" -d @/var/tmp/unredd_geostore_backup.xml http://localhost/stg_geostore/rest/backup/quick/
  EOH
end

template "/var/stg_geoserver/extdata/forest_mask_mosaic/datastore.properties" do
  source "test_data/datastore.properties.erb"
  owner  node['tomcat']['user']
  group  node['tomcat']['user']
  mode   0644
end


execute "set stg_geoserver extdata dir permissions" do
  user "root"
  command <<-EOH
    chown -R #{node['tomcat']['user']}: /var/stg_geoserver/extdata
    find /var/stg_geoserver/extdata -type d -exec chmod 755 {} \\;
    find /var/stg_geoserver/extdata -type f -exec chmod 644 {} \\;
  EOH
end

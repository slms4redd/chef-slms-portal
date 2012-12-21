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

execute "set stg_geoserver extdata dir permissions" do
  user "root"
  command <<-EOH
    chown -R #{node['tomcat']['user']}: /var/stg_geoserver/extdata
    find /var/stg_geoserver/extdata -type d -exec chmod 755 {} \\;
    find /var/stg_geoserver/extdata -type f -exec chmod 644 {} \\;
  EOH
end

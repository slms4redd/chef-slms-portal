name             "unredd-nfms-portal"
maintainer       "Stefano Giaccio"
maintainer_email "stefano.giaccio@fao.org"
license          "GPL v3"
description      "Installs the UNREDD nfms portal"
#long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.9"

# TODO: dependencies
# %w{}.each do |cb|
#   depends cb
# end

%w{ubuntu}.each do |os|
  supports os
end

recipe "unredd-nfms-portal::default", "Installs the portal, includes other unredd-nfms-portal recipes"
recipe "unredd-nfms-portal::apache2_conf", "Configures mod_proxy and mod_proxy_ajp for the UNREDD portal"
recipe "unredd-nfms-portal::db_conf", "Configures PostGIS"
recipe "unredd-nfms-portal::geobatch", "Installs GeoBatch"
recipe "unredd-nfms-portal::geoserver", "Installs staging and dissemination GeoServer"
recipe "unredd-nfms-portal::geostore", "Installs GeoStore"
recipe "unredd-nfms-portal::install_test_data", "Installs portal test data"
recipe "unredd-nfms-portal::jai", "Installs native jai"

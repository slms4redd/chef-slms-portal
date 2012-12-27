# Chef NFMS portal cookbook

## Installation

1. Install vagrant (see http://vagrantup.com/v1/docs/getting-started/index.html)
2. Download this repository with submodules: ``git clone --recursive https://github.com/nfms4redd/chef-nfms-portal.git``
3. Run Vagrant:

        cd chef-nfms-portal
        Vagrant up


## Demo data

DRC demo data is in /var/tmp/drc

The unredd-nfms-portal::install_test_data recipe sets up stg_geoserver, stg_geostore, and stg_geobath data for testing:

``area.tif`` and ``provinces.tif`` are copied in ``/var/stg_geoserver/extdata/forest_mask_mosaic``
the directory ``/var/stg_geoserver/extdata/forest_mask_mosaic`` is created with the .properties


To setup stg_geostore for the demo data type ``curl -u admin:admin -XPUT -H "Content-type: text/xml" -d @/var/tmp/unredd_geostore_backup.xml http://localhost/stg_geostore/rest/backup/quick/`` on the terminal


## Passwords

<table>
  <tr>
    <th>Application</th>
    <th>user</th>
    <th>pwd</th>
  </tr>
  <tr>
    <td>Admin UI</td>
    <td>admin</td>
    <td>Unr3dd</td>
  </tr>
  <tr>
    <td>GeoServer</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
  <tr>
    <td>GeoBatch</td>
    <td>admin</td>
    <td>admin</td>
  <tr>
  <tr>
    <td>GeoStore</td>
    <td>admin</td>
    <td>admin</td>
  <tr>
</table>


## TODO

* install JAI
* Tomcat webapps are deployed in the webapps directory every time chef runs -  check if the webapp version is new and deploy only in that case
* add apache proxy directives from definitions (geobatch.rb, geoserver.rb, and geostore.rb)
* dynamically set schema in geobatch config (now set to public)
* set correct permissions for groovy scripts etc.
* hard coded stuff in geobatch flow config files



GeoStore users are initialized to:

<table>
  <tr>
    <th>user</th>
    <th>role</th>
    <th>pwd</th>
  </tr>
  <tr>
    <td>node['unredd-nfms-portal']['stg_geostore']['web_admin_user']</td>
    <td>ADMIN</td>
    <td>node['unredd-nfms-portal']['stg_geostore']['web_admin_password']</td>
  </tr>
  <tr>
    <td>user</td>
    <td>USER</td>
    <td>node['unredd-nfms-portal']['stg_geostore']['web_admin_password']</td>
  <tr>
</table>

Please note that the user `user` has the same password as the `admin` user

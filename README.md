# Chef NFMS portal cookbook

## Installation

1. Install vagrant (see http://vagrantup.com/v1/docs/getting-started/index.html)
2. Download this repository with submodules: ``git clone --recursive https://github.com/nfms4redd/chef-nfms-portal.git``
3. Run Vagrant:

        cd chef-nfms-portal
        Vagrant up


## TODO

* Tomcat webapps are deployed in the webapps directory every time chef runs -  check if the webapp version is new and deploy only in that case
* add apache proxy directives from definitions (geobatch.rb, geoserver.rb, and geostore.rb)
* add admin ui
* add portal front end
* GeoServer users and passwords are the the default ones - put in some node attibutes or generate dynamically, and set both in geoserver and in geobatch config
* dynamically set schema in geobatch config (now set to public)
* det correct permissions for groovy scripts etc.
* hard coded stuff in geobatch flow config files
* review install instructions


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

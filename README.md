# Chef NFMS portal cookbook


## Description

Installs and configures a complete UNREDD NFMS portal


## Requirements

Platform:

* Ubuntu

The following Opscode cookbooks:

* apache2
* apt
* ark
* build-essential
* database
* java
* logrotate
* postgresql

The following cookbooks:

* tomcat cookbook by Bryan Berry (https://github.com/bryanwb/chef-tomcat)
* gis cookbook by Mario Rodas (https://github.com/marsam/cookbook-gis)



## Installation on a Vagrant virtual machine

1. Install vagrant (see http://vagrantup.com/v1/docs/getting-started/index.html)
2. Download this repository with submodules: ``git clone --recursive https://github.com/nfms4redd/chef-nfms-portal.git``
3. Run Vagrant:

        cd chef-nfms-portal/vagrant
        vagrant up


### Memory allocation

Currently 3GB RAM is allocated for the virtual machine. It can be customized changing the config.vm.customize argument in ``Vagrantfile``:

``config.vm.customize ["modifyvm", :id, "--memory", 3072])``


### Host name

Host name is set to ``unredd`` through the following line in ``Vagrantfile``

``config.vm.host_name = "unredd"``


### Forward ports

Currently only port 80 in the VM is forwarded to port 4567 on the host OS.

``config.vm.forward_port 80, 4567`` in ``Vagrantfile``


### Shared folders

Two shared folders are created:

<table>
  <tr>
    <th>Dir</th>
    <th>Mount point</th>
  </tr>
  <tr>
    <td>cache</td>
    <td>/var/vagrant-cache/</td>
  </tr>
  <tr>
    <td>shared</td>
    <td>~/shared</td>
  <tr>
</table>


The ``cache`` shared directory is also set as the ``chef.provisioning_path``, so that the chef files are not cancelled when rebooting or after destroying the vm.


### Users

Three users are created on the Vagrant virtual machine:

* ``vagrant``
* ``tomcat6``
* ``postgres``

### Applications/services installed


#### Apache 2

Apache 2 is installed through the Opscode apache2 cookbook.

Service name: ``apache2``

The configuration file is ``/etc/apache2/apache2.conf``.

Custom proxy configuration (ajp protocol) is done in ``/etc/apache2/sites-enabled/tomcat_proxy.conf -> `/etc/apache2/sites-available/tomcat_proxy.conf``.

The only other custom configuration is done through ``/etc/apache2/mods-enabled/proxy.conf``


#### Java

Oracle jdk1.6.0_37 is installed using the Opscode java cookbook.


#### Tomcat

Version: 6.0.36

Tomcat is installed with the ``CATALINA_BASE`` method to have multiple instances sharing the same Tomcat installation files.

``CATALINA_HOME=/var/tomcat/default``. ``default`` is a symbolic link to the current Tomcat binary.


#### Postgres

Version: 9.1

Configuration files are in ``/etc/postgresql/9.1/main``

``postgres`` user password is ``postgres``

##### Default databases/owners/passwords:

<table>
  <tr>
    <th>Databases</th>
    <th>Owner</th>
    <th>Owner password</th>
  </tr>
  <tr>
    <td>stg_geoserver</td>
    <td>stg_geoserver</td>
    <td>admin</td>
  </tr>
  <tr>
    <td>diss_geoserver</td>
    <td>diss_geoserver</td>
    <td>admin</td>
  <tr>
  <tr>
    <td>stg_geostore</td>
    <td>stg_geostore</td>
    <td>admin</td>
  <tr>
  <tr>
    <td>diss_geostore</td>
    <td>diss_geostore</td>
    <td>admin</td>
  <tr>
</table>


#### Postgis

Installed through the package manager by the gis cookbook. Currently version  ``2.0.1`` is installed.


#### gdal

Installed through the package manager by the gis cookbook. Currently version  ``1.9.2`` is installed.


### Web applications

The following web applications are installed:

<table>
  <tr>
    <th>Webapp</th>
    <th>URL on the host OS</th>
    <th>User</th>
    <th>Password</th>
  </tr>
  <tr>
    <td>Staging GeoServer</td>
    <td>http://localhost:4567/stg_geoserver</td>
    <td>admin</td>
    <td>Unr3dd</td>
  </tr>
  <tr>
    <td>Dissemination GeoServer</td>
    <td>http://localhost:4567/diss_geoserver</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
  <tr>
    <td>Staging GeoStore</td>
    <td>http://localhost:4567/stg_geostore</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
  <tr>
    <td>Dissemination GeoStore</td>
    <td>http://localhost:4567/diss_geostore</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
  <tr>
    <td>GeoBatch</td>
    <td>http://localhost:4567/stg_geobatch</td>
    <td>admin</td>
    <td>admin</td>
  <tr>
  <tr>
    <td>Portal administration</td>
    <td>http://localhost:4567/admin</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
  <tr>
    <td>Monitoring Portal</td>
    <td>http://localhost:4567/portal</td>
    <td>admin</td>
    <td>Unr3dd</td>
  <tr>
</table>



#### Staging GeoServer

* Webapp directory: ``/var/tomcat/stg_geoserver/webapps/stg_geoserver``
* User: ``admin``
* Password: ``Unr3dd``
* Tomcat http port: ``8201``
* Tomcat ajp port: ``8101``
* database: ``stg_geoserver``
* data directory: ``/var/stg_geoserver/data``
* log file: ``/var/stg_geoserver/logs/geoserver.log``


#### Dissemination GeoServer

* Webapp directory: ``/var/tomcat/diss_geoserver/webapps/diss_geoserver``
* User: ``admin``
* Password: ``Unr3dd``
* Tomcat http port: ``8205``
* Tomcat ajp port: ``8105``
* database: ``diss_geoserver``
* data directory: ``/var/diss_geoserver/data``
* log file: ``/var/diss_geoserver/diss_geoserver/geoserver.log``


#### Staging GeoStore

* Webapp directory: ``/var/tomcat/stg_geostore/webapps/stg_geostore``
* User: ``admin``
* Password: ``Unr3dd``
* Tomcat ``http port: 8200``
* Tomcat ajp port: ``8100``
* database: ``stg_geostore``
* log file: ``/var/tomcat/stg_geostore/logs/catalina.out``


#### Dissemination GeoStore

* Webapp directory: ``/var/tomcat/diss_geostore/webapps/diss_geostore``
* User: ``admin
* Password: ``Unr3dd``
* Tomcat http port: ``8204``
* Tomcat ajp port: ``8104``
* database: ``diss_geostore``
* log file: ``/var/tomcat/diss_geostore/logs/catalina.out``


#### Staging GeoBatch

* Webapp directory: ``/var/tomcat/stg_geobatch/webapps/stg_geobatch``
* User: ``admin``
* Password: ``admin``
* Tomcat http port: ``8202``
* Tomcat ajp port: ``8102``
* Configuration directory: ``/var/stg_geobatch/config``
* Input directory: ``/var/stg_geobatch``
* Temp directory: ``/var/stg_geobatch/temp``


#### Portal administration

* Webapp directory: ``/var/tomcat/stg_geoserver/webapps/admin``
* User: ``admin``
* Password: ``Unr3dd``
* Tomcat http port: ``8201``
* Tomcat ajp port: ``8101``


#### Monitoring Portal

* Webapp directory: ``/var/tomcat/diss_geoserver/webapps/portal``
* Tomcat http port: ``8205``
* Tomcat ajp port: ``8105``
* Configuration directory: ``/var/portal``


## Demo data

DRC demo data is in ``/var/tmp/drc``

The unredd-nfms-portal::install_test_data recipe sets up stg_geoserver, stg_geostore, and stg_geobath data for testing:

* the files``area.tif`` and ``provinces.tif`` are copied in ``/var/stg_geoserver/extdata/forest_mask_mosaic``;

To setup stg_geostore for the demo data, type

``curl -u admin:Unr3dd -XPUT -H "Content-type: text/xml" -d @/var/tmp/unredd_geostore_backup.xml http://localhost/stg_geostore/rest/backup/quick/``

on the terminal




## TODO

* Tomcat webapps are deployed in the webapps directory every time chef runs -  check if the webapp version is new and deploy only in that case
* add apache proxy directives from definitions (``geobatch.rb``, ``geoserver.rb``, and ``geostore.rb``)
* dynamically set schema in geobatch config (now set to public)
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

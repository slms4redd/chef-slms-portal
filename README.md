Chef NFMS portal cookbook
-------------------------


Installation
============

  * Install vagrant (see http://vagrantup.com/v1/docs/getting-started/index.html)
  * Download this repository with submodules: ``https://github.com/nfms4redd/chef-nfms-portal.git``
  * Run Vagrant::

    $ cd chef-nfms-portal
    $ Vagrant up


TODO
====

  * Tomcat webapps are deployed in the webapps directory every time chef runs -  check if the webapp version is new and deploy only in that case
  * add apache proxy directives from definitions (geobatch.rb, geoserver.rb, and geostore.rb)
  * add admin ui
  * add portal front end
  * GeoServer users and passwords are the the default ones - put in some node attibutes or generate dynamically, and set both in geoserver and in geobatch config
  * Dynamically set schema in geobatch config (now set to public)
  * Set correct permissions for groovy scripts etc.
  * Hard coded stuff in geobatch flow config files
  * Review install instructions


geostore users are initialized to:

================================================================ =========     ====================================================================
user                                                             role          pwd
---------------------------------------------------------------- ---------     --------------------------------------------------------------------
``node['unredd-nfms-portal']['stg_geostore']['web_admin_user']`` ``ADMIN``     ``node['unredd-nfms-portal']['stg_geostore']['web_admin_password']``
``user``                                                         ``USER``      ``node['unredd-nfms-portal']['stg_geostore']['web_admin_password']``
================================================================ =========     ====================================================================

Please note that the user ``user`` has the same password as the ``admin`` user

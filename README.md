## Chef NFMS portal cookbook

This repo contains all chef receipts and scripts to automatically deploy the NFMS system.

###Clone this repo

This repo is composed by many git submodules, so you have to use the clone options ``--recursive`` to clone also them::

``git clone --recursive https://github.com/nfms4redd/chef-nfms-portal.git``

###How to use chef for NFMS

The scripts can be used in two different ways:

* Using Vagrant in order to run the deployment process on a standard VM using VirtualBox
* Running the chef process on an external VM in order to use your favourite virtualization system

Read the [wiki](https://github.com/nfms4redd/chef-nfms-portal/wiki) for a complete description about how to use chef and chef+vagrant.

###Useful Links:

[Chef Official Website](http://www.opscode.com/chef/)

[Vagrant Official Website](http://www.vagrantup.com/)

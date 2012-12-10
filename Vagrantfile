# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  # config.vm.box = "lucid32"
  # config.vm.box_url = 'http://files.vagrantup.com/lucid32.box'

  config.vm.forward_port 80, 4567

  config.vm.share_folder "shared", "~/shared", "."

  # Upgrade Chef - getting "TypeError: can't convert nil into String Chef" otherwise. Might not be needed with other versions of precise32
  config.vm.provision :shell, :inline => "gem update chef"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path     = "roles" # not used (yet?)
    chef.data_bags_path = "data_bags" # not used (yet?)


    chef.add_recipe "apt" # execute apt-get update

    #chef.add_recipe "postgresql"
    chef.add_recipe "java"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "database::postgresql"

    chef.add_recipe "gis" # Needed to install PostGIS

    chef.add_recipe "unredd-webapps"

    chef.json = {
      # PostgreSQL configuration
      :postgresql => {
        :version => "9.1",
        :password => {
          :postgres => "postgres" # with chef-solo you must specify them in the json_attribs file used
                                  # TODO: this doesn't seem to have any effect
        },
        :pg_hba => [
          { :type => 'local', :db => 'all', :user => 'postgres', :addr => nil,            :method => 'peer' },
          { :type => 'local', :db => 'all', :user => 'all',      :addr => nil,            :method => 'md5' },
          { :type => 'host',  :db => 'all', :user => 'all',      :addr => '127.0.0.1/32', :method => 'md5' },
          { :type => 'host',  :db => 'all', :user => 'all',      :addr => '::1/128',      :method => 'md5' }
        ]
      },

      # The java cookbook is used to install the Oracle distribution of Java
      :java => {
        :install_flavor => "oracle",
        :oracle => {
          "accept_oracle_download_terms" => true
        }
      },

      # Tomcat will be installed in /var/tomcat/tomcat-6
      # The link /var/tomcat/default -> /var/tomcat/tomcat-6 is also created
      :tomcat => {
        :version => '6',
        :'6' => {
          :url => "http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.36/bin/apache-tomcat-6.0.36.tar.gz",
          #:checksum => "3dde098fd0b3a08d3f2867e4a95591ba"
        },
        :prefix_dir => "/var"
      },

      # The gis cookbook will install gdal, postgis and support libraries
      # TODO: maybe better to use some postgis cookbook
      :gis => {
        :ubuntugis => {
          :repo => "unstable",
          #:packages => %|gdal-bin python-gdal postgresql-9.1 postgresql-server-dev-9.1 libxml2-dev libgeos-dev proj postgis postgresql-9.1-postgis|
          :packages => %|gdal-bin python-gdal libxml2-dev libgeos-dev proj postgis postgresql-9.1-postgis|
        }
      },

      # The unredd webapps will be installed in /var/tomcat/<app_name> by the tomcat cookbook
      :unredd_webapps => {
        # Configuration parameters for the unredd tomcat instances
        # These parameters are for a test virtual machie, leave the default one for a minimal server setup (or override them with bigger values)
        :stg_geostore => {
          :jvm_opts => { :xms => "128m", :xmx => "256m" }
        },
        :diss_geostore => {
          :jvm_opts => { :xms => "128m", :xmx => "256m" }
        },
        :stg_geoserver => {
          :jvm_opts => { :xms => "128m", :xmx => "512m" }
        },
        :diss_geoserver => {
          :jvm_opts => { :xms => "128m", :xmx => "512m" }
        },
        :stg_geobatch => {
          :jvm_opts => { :xms => "128m", :xmx => "512m" }
        },
        :portal => {
          :minified_js => false
        }
      }
    }

  end
end

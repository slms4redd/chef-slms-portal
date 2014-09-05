#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Attributes:: default
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


default['unredd-nfms-portal']['db_name'] = 'unredd'


# Download URLs
default['unredd-nfms-portal']['geoserver_download_url']       = 'http://nfms4redd.org/downloads/geoserver/geoserver-2.5.2+css+wps+monitor.war'
default['unredd-nfms-portal']['geostore_download_url']        = 'http://nfms4redd.org/downloads/geostore/geostore-1.1.0.war'
default['unredd-nfms-portal']['geostore_schema_download_url'] = 'https://raw.github.com/geosolutions-it/geostore/1.0.1/doc/sql/002_create_schema_postgres.sql'


# Staging GeoStore
default['unredd-nfms-portal']['stg_geostore']['root_dir']             = '/var'
default['unredd-nfms-portal']['stg_geostore']['tomcat_instance_name'] = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['tomcat_http_port']     = 8200
default['unredd-nfms-portal']['stg_geostore']['tomcat_ajp_port']      = 8100
default['unredd-nfms-portal']['stg_geostore']['tomcat_shutdown_port'] = 8020
default['unredd-nfms-portal']['stg_geostore']['db_schema']            = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['db_user']              = 'stg_geostore'
default['unredd-nfms-portal']['stg_geostore']['db_password']          = 'admin'
default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xms']      = '512m'
default['unredd-nfms-portal']['stg_geostore']['jvm_opts']['xmx']      = '512m'
default['unredd-nfms-portal']['stg_geostore']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['stg_geostore']['web_admin_password']   = 'Unr3dd'


# Dissemination GeoStore
default['unredd-nfms-portal']['diss_geostore']['root_dir']             = '/var'
default['unredd-nfms-portal']['diss_geostore']['tomcat_instance_name'] = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['tomcat_http_port']     = 8204
default['unredd-nfms-portal']['diss_geostore']['tomcat_ajp_port']      = 8104
default['unredd-nfms-portal']['diss_geostore']['tomcat_shutdown_port'] = 8024
default['unredd-nfms-portal']['diss_geostore']['db_schema']            = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['db_user']              = 'diss_geostore'
default['unredd-nfms-portal']['diss_geostore']['db_password']          = 'admin'
default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xms']      = '512m'
default['unredd-nfms-portal']['diss_geostore']['jvm_opts']['xmx']      = '1024m'
default['unredd-nfms-portal']['diss_geostore']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['diss_geostore']['web_admin_password']   = 'Unr3dd'


# Staging GeoServer
default['unredd-nfms-portal']['stg_geoserver']['root_dir']             = '/var'
default['unredd-nfms-portal']['stg_geoserver']['tomcat_instance_name'] = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['tomcat_http_port']     = 8201
default['unredd-nfms-portal']['stg_geoserver']['tomcat_ajp_port']      = 8101
default['unredd-nfms-portal']['stg_geoserver']['tomcat_shutdown_port'] = 8021
default['unredd-nfms-portal']['stg_geoserver']['db_schema']            = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['db_user']              = 'stg_geoserver'
default['unredd-nfms-portal']['stg_geoserver']['db_password']          = 'admin'
default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xms']      = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['jvm_opts']['xmx']      = '1024m'
default['unredd-nfms-portal']['stg_geoserver']['data_dir']             = '/var/stg_geoserver/data'
default['unredd-nfms-portal']['stg_geoserver']['log_location']         = '/var/stg_geoserver/logs/geoserver.log'
default['unredd-nfms-portal']['stg_geoserver']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['stg_geoserver']['web_admin_password']   = 'Unr3dd'


# Dissemination GeoServer
default['unredd-nfms-portal']['diss_geoserver']['root_dir']             = '/var'
default['unredd-nfms-portal']['diss_geoserver']['tomcat_instance_name'] = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['tomcat_http_port']     = 8205
default['unredd-nfms-portal']['diss_geoserver']['tomcat_ajp_port']      = 8105
default['unredd-nfms-portal']['diss_geoserver']['tomcat_shutdown_port'] = 8025
default['unredd-nfms-portal']['diss_geoserver']['db_schema']            = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['db_user']              = 'diss_geoserver'
default['unredd-nfms-portal']['diss_geoserver']['db_password']          = 'admin'
default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xms']      = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['jvm_opts']['xmx']      = '1024m'
default['unredd-nfms-portal']['diss_geoserver']['data_dir']             = '/var/diss_geoserver/data'
default['unredd-nfms-portal']['diss_geoserver']['log_location']         = '/var/diss_geoserver/logs/geoserver.log'
default['unredd-nfms-portal']['diss_geoserver']['web_admin_user']       = 'admin'
default['unredd-nfms-portal']['diss_geoserver']['web_admin_password']   = 'Unr3dd'


# Staging GeoBatch
default['unredd-nfms-portal']['stg_geobatch']['root_dir']             = '/var/stg_geobatch'
default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xms']      = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['jvm_opts']['xmx']      = '2048m'
default['unredd-nfms-portal']['stg_geobatch']['config_dir']           = "#{node['unredd-nfms-portal']['stg_geobatch']['root_dir']}/config"
default['unredd-nfms-portal']['stg_geobatch']['temp_dir']             = "#{node['unredd-nfms-portal']['stg_geobatch']['root_dir']}/temp"
default['unredd-nfms-portal']['stg_geobatch']['tomcat_http_port']     = 8202
default['unredd-nfms-portal']['stg_geobatch']['tomcat_ajp_port']      = 8102
default['unredd-nfms-portal']['stg_geobatch']['tomcat_shutdown_port'] = 8022


# Admin
default['unredd-nfms-portal']['admin']['password']  = 'Unr3dd'

# Portal
default['unredd-nfms-portal']['portal']['config_dir']  = '/var/portal/'
default['unredd-nfms-portal']['portal']['minified_js'] = true

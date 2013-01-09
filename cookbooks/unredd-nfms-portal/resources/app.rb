#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Resource:: app
#
# (C) 2012, FAO Forestry Department (http://www.fao.org/forestry/)
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


actions :install

attribute :app_name, :name_attribute => true
attribute :tomcat_instance, :kind_of => String
attribute :download_url, :kind_of => String
attribute :user, :kind_of => String

attr_accessor :base

def initialize(*args)
  require 'pathname'
  super

  @action = :install

  catalina_parent = Pathname.new(node['tomcat']['home']).parent.to_s
  @base = "#{catalina_parent}/#{tomcat_instance}"

  #puts "Base dir is #{@base}" # DEBUG

  #@supports = {:report => true, :exception => true}
end

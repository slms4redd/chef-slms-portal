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

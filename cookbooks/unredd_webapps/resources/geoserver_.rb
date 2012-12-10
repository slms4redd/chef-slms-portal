actions :install

attribute :instance_name, :name_attribute => true
attribute :download_url, :kind_of => String

#attr_accessor :base

def initialize(*args)
  super
  @action = :install
  
  #@supports = {:report => true, :exception => true}
end

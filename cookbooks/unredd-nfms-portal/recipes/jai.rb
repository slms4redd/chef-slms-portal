jai_arch             = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i586"
jai_version          = node['unredd-nfms-portal']['jai']['jai_version'].gsub(/\./, "_")
jai_imageio_version  = node['unredd-nfms-portal']['jai']['jai_imageio_version']

# Note: use of underscores and dots is not consistent. There might be problems when version changes
jai_filename         = "jai-#{jai_version}-lib-linux-#{jai_arch}"
jai_imageio_filename = "jai_imageio-#{jai_imageio_version.gsub(/\./, "_")}-lib-linux-#{jai_arch}"

java_arch            = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"

jai_url         = "http://download.java.net/media/jai/builds/release/#{jai_version}/#{jai_filename}.tar.gz"
jai_imageio_url = "http://download.java.net/media/jai-imageio/builds/release/#{jai_imageio_version}/#{jai_imageio_filename}.tar.gz"


ark jai_filename do
  url    jai_url
  path   "/var/tmp"
  action :put
end

ark jai_imageio_filename do
  url    jai_imageio_url
  path   "/var/tmp"
  action :put
end

execute "install jai" do
  user "root"
  command <<-EOH
    cp /var/tmp/#{jai_filename}/lib/*.jar #{node['java']['java_home']}/jre/lib/ext
    cp /var/tmp/#{jai_filename}/lib/*.so #{node['java']['java_home']}/jre/lib/#{java_arch}
    cp /var/tmp/#{jai_imageio_filename}/lib/*.jar #{node['java']['java_home']}/jre/lib/ext
    cp /var/tmp/#{jai_imageio_filename}/lib/*.so #{node['java']['java_home']}/jre/lib/#{java_arch}
  EOH
end

ark 'jai' do
  url    node['unredd-nfms-portal']['jai']['jai_download_url']
  path   "/var/tmp"
  action :put
end

ark 'jai_imageio' do
  url    node['unredd-nfms-portal']['jai']['jai_imageio_download_url']
  path   "/var/tmp"
  action :put
end

execute "install jai" do
  user "root"
  command <<-EOH
    cp /var/tmp/jai/lib/*.jar #{node['java']['java_home']}/jre/lib/ext
    cp /var/tmp/jai/lib/*.so #{node['java']['java_home']}/jre/lib/i386
    cp /var/tmp/jai_imageio/lib/*.jar #{node['java']['java_home']}/jre/lib/ext
    cp /var/tmp/jai_imageio/lib/*.so #{node['java']['java_home']}/jre/lib/i386
  EOH
end

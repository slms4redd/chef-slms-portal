include_recipe "apache2"
include_recipe "apache2::mod_proxy"

#apache_module "proxy" do
#end

include_recipe "apache2::mod_proxy_ajp"

web_app "tomcat_proxy" do
  template "unredd_proxy_template.conf.erb"
  owner "apache"
  mode 0750
end

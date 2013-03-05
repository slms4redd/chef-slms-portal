#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Recipe:: db_conf
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


# # Configure PostGIS
# execute "configure postgis" do
#   user "postgres"
#   command <<-EOH
#   createdb template_postgis
#   psql -d template_postgis -c "UPDATE pg_database SET datistemplate=true WHERE datname='template_postgis'"
#   psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis.sql
#   psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/spatial_ref_sys.sql
#   psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis_comments.sql
#   EOH

#   not_if 'psql -t -c "select datname from pg_catalog.pg_database where datname = \'template_postgis\'" | grep -c template_postgis', :user => 'postgres'
# end


db_name = node['unredd-nfms-portal']['db_name']
postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

# Create the unredd database
postgresql_database db_name do
  connection postgresql_connection_info
  # template   'template_postgis'
  # encoding   'UTF8'
  # collation  'en_US.utf8'
  encoding   'DEFAULT'
  tablespace 'DEFAULT'

  action     :create
end

execute "setup db #{db_name}" do
  user "postgres"
  command <<-EOH
    psql -c \"CREATE EXTENSION postgis;\" -d #{db_name}
    psql -c \"REVOKE CREATE ON SCHEMA public FROM public;\" -d #{db_name}
  EOH
end

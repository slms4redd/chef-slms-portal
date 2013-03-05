#
# Author:: Stefano Giaccio (<stefano.giaccio@fao.org>)
# Cookbook Name:: unredd-nfms-portal
# Definition:: geostore
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


# As we need two instances of GeoStore for the full NFMS portal we are using a definition

define :user_schema do
  db_schema   = params[:name]
  db_user     = params[:db_user]
  db_password = params[:db_password]

  db_name     = node['unredd-nfms-portal']['db_name']

  postgresql_connection_info = { :host => "localhost", :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

  postgresql_database_user db_user do
    connection postgresql_connection_info
    password   db_password
    action     :create
  end

  execute "create #{db_schema} schema" do
    user "postgres"
    command "psql -c \"CREATE SCHEMA #{db_schema}\" -d #{db_name}";

    not_if "psql -tc \"SELECT schema_name FROM information_schema.schemata WHERE schema_name = '#{db_schema}';\" -d #{db_name} | grep -c #{db_schema}", :user => 'postgres'
  end

  execute "setup #{db_schema} schema" do
    user "postgres"
    command <<-EOH
      psql -c \"ALTER SCHEMA #{db_schema} OWNER TO #{db_user};" -d #{db_name}
      #psql -c \"GRANT USAGE ON SCHEMA #{db_schema} TO #{db_user};\" -d #{db_name}
      #psql -c \"GRANT ALL ON SCHEMA #{db_schema} TO #{db_user};\" -d #{db_name}
      psql -c \"GRANT SELECT ON public.spatial_ref_sys TO #{db_user};\" -d #{db_name}
      psql -c \"GRANT SELECT,INSERT,DELETE ON public.geometry_columns TO #{db_user};\" -d #{db_name}
      psql -c \"ALTER USER #{db_user} SET SEARCH_PATH to #{db_schema}, public;\" -d #{db_name}
    EOH

    not_if "psql -t -c \"SELECT schema_name FROM information_schema.schemata WHERE schema_name = '#{db_schema}';\" | grep -c #{db_schema}", :user => 'postgres'
  end
end

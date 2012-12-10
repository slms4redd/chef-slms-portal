#case node['platform']
#when "ubuntu"
  #package "chkconfig"

  # Configure PostGIS
  execute "configure postgis" do
    user "postgres"  
    command <<-EOH    
    createdb template_postgis
    psql -d template_postgis -c "UPDATE pg_database SET datistemplate=true WHERE datname='template_postgis'"
    psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis.sql
    psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/spatial_ref_sys.sql
    psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis_comments.sql
    EOH

    not_if 'psql -t -c "select datname from pg_catalog.pg_database where datname = \'template_postgis\'" | grep -c template_postgis', :user => 'postgres'
  end


  #############################################################################
  # Create users
  #############################################################################

#   # Create stg_geostore user
#   execute "create stg_geostore user" do
#     user 'postgres'
#     command <<-EOH
# echo "CREATE USER stg_geostore LOGIN PASSWORD 'admin'  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql
#     EOH

#     not_if 'psql -c "select * from pg_user where usename=\'stg_geostore\'" | grep -c stg_geostore', :user => 'postgres'
#   end

#   # Create diss_geostore user
#   execute "create diss_geostore user" do
#     user 'postgres'
#     command <<-EOH
# echo "CREATE USER diss_geostore LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql
#     EOH

#     not_if 'psql -c "select * from pg_user where usename=\'diss_geostore\'" | grep -c diss_geostore', :user => 'postgres'
#   end

#   # Create stg_geoserver user
#   execute "create stg_geoserver user" do
#     user 'postgres'
#     command <<-EOH
# echo "CREATE USER stg_geoserver LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql
#     EOH

#     not_if 'psql -c "select * from pg_user where usename=\'stg_geoserver\'" | grep -c stg_geoserver', :user => 'postgres'
#   end
  
#   # Create diss_geoserver user
#   execute "create diss_geoserver user" do
#     user 'postgres'
#     command <<-EOH
# echo "CREATE USER diss_geoserver LOGIN PASSWORD 'admin' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql
#     EOH

#     not_if 'psql -c "select * from pg_user where usename=\'diss_geoserver\'" | grep -c diss_geoserver', :user => 'postgres'
#   end

  
#   #############################################################################
#   # Create databases
#   #############################################################################

#   # Create stg_geostore database
#   execute "create stg_geostore database" do
#     user 'postgres'
#     command "createdb -O stg_geostore stg_geostore"

#     not_if 'psql -c "SELECT * from pg_database WHERE datname=\'stg_geostore\'" | grep -c stg_geostore', :user => 'postgres'
#   end

#   # Create diss_geostore database
#   execute "create diss_geostore database" do
#     user 'postgres'
#     command "createdb -O diss_geostore diss_geostore"

#     not_if 'psql -c "SELECT * from pg_database WHERE datname=\'diss_geostore\'" | grep -c diss_geostore', :user => 'postgres'
#   end

#   # Create stg_geoserver database
#   execute "create stg_geoserver database" do
#     user 'postgres'
#     command <<-EOH
# createdb -O stg_geoserver -T template_postgis stg_geoserver
# psql stg_geoserver -c "GRANT ALL ON geometry_columns TO stg_geoserver"
#     EOH

#     not_if 'psql -c "SELECT * from pg_database WHERE datname=\'stg_geoserver\'" | grep -c stg_geoserver', :user => 'postgres'
#   end


#   #############################################################################
#   # Configure PostgreSQL access
#   #############################################################################

#   # TODO: check if the file has already been modified?
#   template "/etc/postgresql/9.1/main/pg_hba.conf" do
#     source "pg_hba.conf.erb"
#     mode "0755"
#   end


#   #############################################################################
#   # Restart and configure PostgreSQL autostart
#   #############################################################################

#   execute "restart and configure postgresql autostart" do
#     user 'root'
#     command  <<-EOH
#     sudo /etc/init.d/postgresql restart
#     chkconfig -s postgresql on
#     EOH
#   end

# else
#   Chef::Log.warn("This cookbook is not yet supported on #{node['platform']}")
# end

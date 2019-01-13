
# Cookbook:: mysql
# Recipe:: setup
#
# Copyright:: 2019, The Authors, All Rights Reserved.

execute 'create user' do
  command <<-EOH
  mysql -u root -e "CREATE USER 'wiki1'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED'";
  EOH
end

execute 'create database' do
  command <<-EOH
  mysql -u root -e "CREATE DATABASE wikidatabase1";
  EOH
end

execute 'grant privileges' do
  command <<-EOH
  mysql -u root -e "GRANT ALL PRIVILEGES ON wikidatabase1.* TO 'wiki1'@'localhost';"
  EOH
end

execute 'show grants' do
  command <<-EOH
  mysql -u root -e "SHOW GRANTS FOR 'wiki1'@'localhost'";
  EOH
end

execute 'flush privileges' do
  command <<-EOH
  mysql -u root -e "FLUSH PRIVILEGES"
  EOH
end
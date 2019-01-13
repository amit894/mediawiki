
# Cookbook:: mysql
# Recipe:: setup
#
# Copyright:: 2019, The Authors, All Rights Reserved.

secret = Chef::EncryptedDataBagItem.load_secret('/etc/chef/encrypted_data_bag_secret')
  keys = Chef::EncryptedDataBagItem.load("mysql", "wikiuser", secret)
  username = keys["dev"]["username"]
  password = keys["dev"]["password"]

execute 'create user' do
  command <<-EOH
  mysql -u root -e "CREATE USER '#{username}'@'localhost' IDENTIFIED BY '#{password}'";
  EOH
end

execute 'create database' do
  command <<-EOH
  mysql -u root -e "CREATE DATABASE devwiki";
  EOH
end

execute 'grant privileges' do
  command <<-EOH
  mysql -u root -e "GRANT ALL PRIVILEGES ON devwiki.* TO '#{username}'@'localhost';"
  EOH
end

execute 'show grants' do
  command <<-EOH
  mysql -u root -e "SHOW GRANTS FOR '#{username}'@'localhost'";
  EOH
end

execute 'flush privileges' do
  command <<-EOH
  mysql -u root -e "FLUSH PRIVILEGES"
  EOH
end
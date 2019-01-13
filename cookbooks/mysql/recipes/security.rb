
# Cookbook:: mysql
# Recipe:: security
#
# Copyright:: 2019, The Authors, All Rights Reserved.




  secret = Chef::EncryptedDataBagItem.load_secret('/etc/chef/encrypted_data_bag_secret')
  keys = Chef::EncryptedDataBagItem.load("mysql", "root", secret)
  password = keys["dev"]["password"]


execute 'set root user password' do
  command <<-EOH
  mysql -u root -e "UPDATE mysql.user SET Password='#{password}' WHERE User='root'";
  EOH
end

execute 'delete root remote login' do
  command <<-EOH
  mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')";
  EOH
end

execute 'delete null users' do
  command <<-EOH
  mysql -u root -e "DELETE FROM mysql.user WHERE User=''";
  EOH
end

execute 'delete test datbases' do
  command <<-EOH
  mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'";
  EOH
end

execute 'flush privileges' do
  command <<-EOH
  mysql -u root -e "FLUSH PRIVILEGES";
  EOH
end

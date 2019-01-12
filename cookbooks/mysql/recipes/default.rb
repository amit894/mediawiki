#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package "mariadb" do
  action :install
end

package "mariadb-server" do
  action :install
end


service "mariadb" do
  action [:enable, :start]
end
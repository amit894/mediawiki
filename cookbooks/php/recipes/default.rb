#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.


package "php" do
  action :install
end

package "php-mysql" do
  action :install
end

package "php-xml" do
  action :install
end

package "php-gd" do
  action :install
end

package "php-mbstring" do
  action :install
end



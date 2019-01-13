#
# Cookbook:: httpd
# Recipe:: medikwiki
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package "wget" do
  action :install
end

execute "download mediwiki" do
  cwd node['httpd']['mediawiki']['user']
  command "wget https://releases.wikimedia.org/mediawiki/#{node['httpd']['mediawiki']['version']}/#{node['httpd']['mediawiki']['tar']}"
end

execute "download GPG signature" do
  cwd node['httpd']['mediawiki']['user']
  command "wget https://releases.wikimedia.org/mediawiki/#{node['httpd']['mediawiki']['version']}//#{node['httpd']['mediawiki']['sigtar']}"
end

# execute "verify GPG signature" do
#   cwd node['httpd']['mediawiki']['user']
#   command "gpg --verify node['httpd']['mediawiki']['sigtar'] node['httpd']['mediawiki']['tar']"
# end

execute "untar mediwiki" do
  cwd node['httpd']['mediawiki']['var']
  command "tar -zxf #{node['httpd']['mediawiki']['user']}/#{node['httpd']['mediawiki']['tar']}"
end

execute "create symlink" do
  cwd node['httpd']['mediawiki']['var']
  command "ln -s mediawiki-1.32.0/ mediawiki"
end

template '/etc/httpd/conf/httpd.conf' do
	source 'httpd.conf.erb'
end

service 'httpd' do
 	action :restart
end
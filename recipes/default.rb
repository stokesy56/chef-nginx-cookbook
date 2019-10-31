#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update
package 'nginx'

service "nginx" do
  action [:enable, :start]
end
# template 'destination' do
#   source 'name_file_in_template.conf.erb'
# end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  #variables(proxy_port: node['nginx']['proxy_port'],
    #proxy_port2: node['nginx']['proxy_port_2'])
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
end

 link '/etc/nginx/sites-enabled/default' do
   action :delete
   notifies :restart, "service[nginx]"
 end

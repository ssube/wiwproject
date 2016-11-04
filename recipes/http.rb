#
# Cookbook Name:: wiwproject
# Recipe:: www
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'nginx::repo'

package 'nginx' do
  action :install
end

package 'hhvm' do
  action :install
end

template '/etc/nginx/sites-enabled/wiw-http.conf' do
  source 'http-conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:enable, :restart]
end

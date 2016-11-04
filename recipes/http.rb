include_recipe 'hhvm'
include_recipe 'nginx'

template "#{node['nginx']['dir']}/sites-available/blog" do
  source 'http-conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

nginx_site 'default' do
  enable false
end

nginx_site 'blog' do
  enable true
end

service 'hhvm' do
  action [:enable, :restart]
end

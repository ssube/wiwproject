mysql_service 'blog' do
  bind_address node['db_addr']
  port node['db_port']
  initial_root_password node['db_root']
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

package 'build-essential' do
  action :install
end

package 'libmysqlclient-dev' do
  action :install
end

mysql2_chef_gem 'default' do
  action :install
end
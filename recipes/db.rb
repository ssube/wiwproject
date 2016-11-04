mysql_service 'blog' do
  bind_address node['db_addr']
  port node['db_port']
  initial_root_password node['db_root']
  action [:create, :start]
end

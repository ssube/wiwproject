directory node['blog_path'] do
  action :create
end

tar_extract 'http://wordpress.org/latest.tar.gz' do
  target_dir node['blog_path']
  creates "#{node['blog_path']}/index.php"
end

template "#{node['blog_path']}/wp-config.php" do
  source 'blog-config.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

mysql_database_user node['db_user'] do
  password node['db_pass']
  connection(
    :host => node['db_host'],
    :port => node['db_port'],
    :username => 'root',
    :password => node['db_root']   
  )
  database_name node['db_name']
end

mysql_database node['db_name'] do
  connection(
    :host => node['db_host'],
    :port => node['db_port'],
    :username => 'root',
    :password => node['db_root']   
  )
  action :create
end
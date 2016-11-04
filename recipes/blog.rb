directory node['blog_path'] do
  action :create
  recursive true
end

tar_extract 'http://wordpress.org/latest.tar.gz' do
  creates "#{node['blog_path']}/index.php"
  target_dir node['blog_path']
  tar_flags [ '--strip-components 1' ]
end

template "#{node['blog_path']}/wp-config.php" do
  source 'blog-config.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'blog-www-chown' do
  command "chown -R www-data:www-data #{node['blog_path']}"
  user 'root'
end

execute 'blog-www-chmod-dir' do
  command "find #{node['blog_path']} -type d -print0 | xargs -0 chmod 0755"
  user 'root'
end

execute 'blog-www-chmod-file' do
  command "find #{node['blog_path']} -type f -print0 | xargs -0 chmod 0644"
  user 'root'
end

mysql_database_user node['db_user'] do
  connection(
    :host => node['db_host'],
    :port => node['db_port'],
    :username => 'root',
    :password => node['db_root']   
  )
  password node['db_pass']
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

mysql_database_user node['db_user'] do
  connection(
    :host => node['db_host'],
    :port => node['db_port'],
    :username => 'root',
    :password => node['db_root']   
  )
  action :grant
  database_name node['db_name']
  privileges [:all]
end
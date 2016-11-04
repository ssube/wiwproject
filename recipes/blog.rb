directory "#{node['blog_path']}" do
  action :create
end

template "#{node['blog_path']}/index.php" do
  source 'http-index.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

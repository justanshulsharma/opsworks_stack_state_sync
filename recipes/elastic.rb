require 'resolv'


service "elasticsearch" do
  supports status: true, restart: true
  action [ :enable ]
end

# Create ES config file
#
template "elasticsearch.yml" do
  path   "/usr/local/etc/elasticsearch/elasticsearch.yml"
  source 'elasticsearch.yml.erb'
  owner  'elasticsearch' and 'elasticsearch' and mode 0755
  variables(
  	localhost_name: node[:opsworks][:instance][:hostname],
    nodes: search(:node, "name:*")
  )
  notifies :restart, 'service[elasticsearch]'
end


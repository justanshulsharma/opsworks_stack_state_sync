require 'resolv'


service "elasticsearch" do
  supports status: true, restart: true
  action [ :enable ]
  only_if { File.exist?("/etc/init.d/elasticsearch") }
end

# Create ES config file
#
template "elasticsearch.yml" do
  path   "/usr/local/etc/elasticsearch/elasticsearch.yml"
  source 'elasticsearch.yml.erb'
  owner  'elasticsearch' and 'elasticsearch' and mode 0755
  variables(
    nodes: search(:node, "name:*")
  )
  notifies :restart, 'service[elasticsearch]'
end


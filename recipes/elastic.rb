require 'resolv'
include_recipe 'ulimit::default'
# Create ES config file
#
template "elasticsearch.yml" do
  path   "#{node.elasticsearch[:path][:conf]}/elasticsearch.yml"
  source node.elasticsearch[:templates][:elasticsearch_yml]
  owner  node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755
  variables(
    nodes: search(:node, "name:*")
  )
  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end


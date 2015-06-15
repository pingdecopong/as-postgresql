
case node['platform_family']
  when 'rhel'
    include_recipe 'as-postgresql::server_rhel'
  else
end





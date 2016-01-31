#
# Cookbook Name:: autofs_wrapper
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node['autofs'].each do |path, o|
  automaster_entry path, o['config_file'] do
    options o['master_options'].join(' ')
  end

  o['maps'].each do |entry, m|
    map_entry entry do
      location m['location']
      fstype m['fstype']
      options m['options'].join(',')
      map o['config_file']
    end
  end
end

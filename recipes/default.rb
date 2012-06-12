# Author:: Sylvain Niles (<sylvain.niles@gmail.com>)
# Cookbook Name:: sumologic
# Recipe:: default
#
# Copyright 2012, Outright, Inc.
#
# MIT
#
#
cookbook_file "/etc/init.d/collector" do
  source "collector.init"
  owner "root"
  group "root"
  mode 0754
end

# Define SumoLogic service
service "collector" do
  supports :restart => true, :reload => true
  action [ :enable ]
end

# Create sumologic install dir
directory "/usr/local/sumologic" do
  owner "root"
  group "root"
  mode "755"
end


sumo_bins = ["collector", "libwrapper.so", "wrapper"]

sumo_bins.each do | bin |
  cookbook_file "/usr/local/sumologic/#{bin}" do
  source bin
  mode 0755
  notifies :restart, resources(:service => "collector"), :delayed
  end
end


sumo_dirs = ["bin", "config", "installerSources"]

sumo_dirs.each do | dir |
  remote_directory "/usr/local/sumologic/#{dir}" do
  source dir
  files_owner "root"
  files_group "root"
  files_mode "0755"
  mode "0755"
  end
end

remote_directory "/usr/local/sumologic/lib" do
  source "lib"
  files_owner "root"
  files_group "root"
  files_mode "0755"
  mode "0755"
  notifies :restart, resources(:service => "collector"), :delayed
end


template "/usr/local/sumologic/installerSources/sources.json" do
  source "sources.erb"
  mode 0644
  notifies :restart, resources(:service => "collector"), :delayed
end

template "/usr/local/sumologic/config/wrapper.conf" do
  source "wrapper.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "collector"), :delayed
end

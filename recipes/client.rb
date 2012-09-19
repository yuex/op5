#!/usr/bin/env ruby
chef_gem "rest-client" do
    action :install
end

op5_object "host" do
    server node['server']
    type 'host'
    data node['host']
    action :create
end

op5_object "ping" do
    server node['server']
    type 'service'
    data node['ping']
    action :create
end

op5_object "load" do
    server node['server']
    data node['load']
    action :create
    type 'service'
end

op5_object "root_disk" do
    server node['server']
    data node['root_disk']
    action :create
    type 'service'
end

op5_object "total_procs" do
    server node['server']
    data node['total_procs']
    action :create
    type 'service'
end

op5_object "swap" do
    server node['server']
    data node['swap']
    action :create
    type 'service'
end

op5_object "confirm" do
    type "change"
    server node['server']
    action :confirm
end

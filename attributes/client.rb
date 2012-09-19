#!/usr/bin/env ruby
default['server'] = {
    "fqdn" => '59.66.201.218',
    "user" => 'monitor',
    "pass" => 'monitor'
}

default['host'] = {
     "address" => "#{node['ipaddress']}",
     "alias" => "#{node['fqdn']}",
     "host_name" => "#{node['fqdn']}"
}

default['ping'] = {
    "check_command" => "check_ping",
    "host_name" => "#{node['fqdn']}",
    "service_description" => "PING",
    "check_command_args" => "100.0,20%!500.0,60%"
}

default['load'] = {
    "check_command" => "check_nrpe",
    "host_name" => "#{node['fqdn']}",
    "service_description" => "System Load",
    "check_command_args" => "load"
}

default['root_disk'] = {
    "check_command" => "check_nrpe",
    "host_name" => "#{node['fqdn']}",
    "service_description" => "Disk Root",
    "check_command_args" => "root_disk"
}

default['total_procs'] = {
    "check_command" => "check_nrpe",
    "host_name" => "#{node['fqdn']}",
    "service_description" => "Total Processes",
    "check_command_args" => "total_procs"
}

default['swap'] = {
    "check_command" => "check_swap",
    "host_name" => "#{node['fqdn']}",
    "service_description" => "Swap Usage",
    "check_command_args" => "20!10"
}

Description
===========

Configures op5 clients (for current version, more features will be added in the future)

Requirements
============

rubygems
--------

* rest-client - recipe::client uses rest-client to access the apis of op5 server. recipe::client will install it from gem if missing 

Platform
--------

* Centos
Tested on centos 6.3

Recipe
======

client
------

Register host object and service objects for the client running recipe::client to op5 server

Op5 servers, host objects and service objects are defined in attributes/client.rb. By default, op5 server is set to localhost, host object is set to the node executing recipe::client. And service objects are set to ping, load, root disk, total processes, swap.

Recipe::client will check if rubygem rest-client is available, if not install it. And then create host object for current node, service objects for ping, load, root disk, total processes, swap in op5 server by accessing REST-API. Finally, recipe::client will confirm the changes have been made to the op5 server to make the changes permanent and show up in the webUI of op5 server


Attributes
==========

client
------

Most attributes comply with naming convention of op5 server, check out host objects and service objects in op5 docs

* `node['server']` - op5 server information, used to define op5 host object for the client.
* `node['host']` - op5 client information, host object 
* `node['ping']` and other services - op5 service objects defination

The key name doens't matter, just make sure you refer to the same attribute in client.rb, if you want to modify recipe::client

You can define your service or host objects in attributes/client.rb. To do so, provide at least four key-value pairs `check_command`, `host_name`, `service_description`, `check_command_args`, for more keys, check out service or host object respectively in op5 docs

Resources/Providers
===================

object
------

# Actions

- :create - create op5 object, if object already existed, try to overwrite
- :remove - remove op5 object
- :confirm - confirm the changes have been made to op5 server. without confirm, the changes won't show up in the webUI

# Attribute Parameters

- type - 'host' or 'service' or 'change', indicates this object is host object or service object, or is executing confirming action
- data - attribute defined in attribues/client.rb, make sure this data complies with type, namely, host object for host type, service object for service type
- server - attribute defined in attribues/client.rb, make sure this is the the server attribute containing the op5 server info

# Example
    
    # create host object
    op5_object "host" do
        server node['server']
        type 'host'
        data node['host']
        action :create
    end

    # create service object 'ping'
    op5_object "ping" do
        server node['server']
        type 'service'
        data node['ping']
        action :create
    end

    # confirm changes
    op5_object "confirm" do
        type "change"
        server node['server']
        action :confirm
    end

License and Author
==================

Written by Xin Yue (yuecn41 at gmail dot com) and Wuming Zhang (wumingzhang at gmail dot com)

Copyright 2012 Xin Yue and Wuming Zhang

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

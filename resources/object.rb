#!/usr/bin/env ruby
actions :create, :remove, :confirm

attribute :name, :kind_of => String, :name_attribute => true
attribute :type, :kind_of => String, :regex => [/service/, /host/, /change/], :required => true
attribute :data, :kind_of => Hash, :default => nil
attribute :server, :kind_of => Hash, :required => true

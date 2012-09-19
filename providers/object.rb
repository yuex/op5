#!/usr/bin/env ruby
require 'rubygems'
require 'rest-client'
require 'json'

action :create do
    op5 = @new_resource.server
    type = @new_resource.type
    json = {}
    @new_resource.data.each do |k,v|
        json[k] = v
    end

    case type
    when "change"
        obj = ''
    when "service"
        obj = "#{json["host_name"]};#{json["service_description"]}"
    when "host"
        obj = json["host_name"]
    else
        raise "wrong object name: #{type}"
    end

    urltype = "https://#{op5["user"]}:#{op5["pass"]}@#{op5["fqdn"]}/api/config/#{type}"
    urlobj = "#{urltype}/#{obj}"
    urltype = URI.escape(urltype)
    urlobj = URI.escape(urlobj)

    response = RestClient.post(urltype, json.to_json, :content_type => :json, :accept => :json){|response, request, result, &block| 
        case response.code
        when 201
            Chef::Log.info("#{obj} created successfully")
        when 409 # meet conficts
            Chef::Log.info("#{obj} existed, trying to overwrite...")

            response = RestClient.get(urlobj, {:accept => :json})
            msge = JSON.parse(response.body)

            if type == 'host' and msge['address'] != json["address"]
                # host_name exists, and ip differs
                raise "hostname conflicts. postin #{json["host_name"]}:#{json["address"]}, but #{msge["host_name"]}:#{msge["address"]} exists"
            end

            RestClient.put(urlobj, json.to_json, :content_type => :json, :accept => :json)
            Chef::Log.info("#{obj} overwrited successfully")
        else
            #raise "response code #{response.code}\n#{response}\ncome to a stop"
            response.return!(request, result, &block)
        end
    }
    @new_resource.updated_by_last_action(true)

end

action :remove do
    op5 = @new_resource.server
    json = @new_resource.data
    type = @new_resource.type

    case type
    when "change"
        obj = ''
    when "service"
        obj = "#{json["host_name"]};#{json["service_description"]}"
    when "host"
        obj = json["host_name"]
    else
        raise "wrong object name: #{type}"
    end

    urltype = "https://#{op5["user"]}:#{op5["pass"]}@#{op5["fqdn"]}/api/config/#{type}"
    urlobj = "#{urltype}/#{obj}"
    urltype = URI.escape(urltype)
    urlobj = URI.escape(urlobj)

    RestClient.delete(urlobj)
    Chef::Log.info("#{obj} removed successfully")
    @new_resource.updated_by_last_action(true)
end

action :confirm do
    op5 = @new_resource.server
    json = @new_resource.data
    type = @new_resource.type

    urltype = "https://#{op5["user"]}:#{op5["pass"]}@#{op5["fqdn"]}/api/config/change"
    urltype = URI.escape(urltype)

    response = RestClient.post(urltype, nil)
    Chef::Log.info("#{response}")
    
    @new_resource.updated_by_last_action(true)
end

require 'uri'
require 'net/http'
require 'json'
require 'mime/types'
module Reggora
  class ApiClient
    $base_api_uri = 'https://sandbox.reggora.io/'

    def self.authenticate(username, password, type)
      body = {:username => username, :password => password}

      response = Net::HTTP.post URI("#{$base_api_uri}#{type}/auth"), body.to_json
      case response
      when Net::HTTPSuccess then
        JSON.parse(response.read_body)
      when Net::HTTPBadRequest then
        res = JSON.parse(response.read_body)
        raise res.inspect if res["error"].nil?
        print res
      when Net::HTTPUnauthorized then
        raise "Unauthorized."
      when Net::HTTPInternalServerError then
        raise "Internal server error"
      else
        raise "Unknown error #{response}: #{response.inspect}"
      end
    end
  end
end
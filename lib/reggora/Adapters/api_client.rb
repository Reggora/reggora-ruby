require 'uri'
require 'net/http'
require 'json'
class ApiClient
  $base_api_uri = 'https://sandbox.reggora.io/'

  def self.authenticate(username, password, type)
    body = {:username => username, :password => password}

    response = Net::HTTP.post URI("#{$base_api_uri}#{type}/auth"), body.to_json
    case response
    when Net::HTTPSuccess then
      JSON.parse(response.read_body)
    else
      response.value
    end
  end
end
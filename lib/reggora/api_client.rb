require 'uri'
require 'net/http'
require 'json'
class ApiClient
  $base_api_uri = 'https://sandbox.reggora.io/'

  # @param [String] email
  # @param [String] password
  # @param [String] integration_token
  #
  def initialize(auth_token, integration_token, type)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
    @type = type
    @header = {"Content-Type" => 'application/json', "Authorization" => auth_token, "integration" => integration_token}
  end

  # @param [string] email
  # @param [string] password
  # @param [string] type => lender/vendor
  # @return [Object]
  def self.authenticate(email, password, type)
    body = {:username => email, :password => password}

    response = Net::HTTP.post URI("#{$base_api_uri}#{type}/auth"), body.to_json
    case response
    when Net::HTTPSuccess then
      JSON.parse(res.read_body)
    else
      print "\n~~~~~~~~HTTP NOT Succeeded~~~~~~~~~~~~~\n"
      print response.inspect
      response.value
    end
  end

  def get(url, params = {})
    @uri = URI($base_api_uri + url)
    @uri.query = URI.encode_www_form(params) unless params.empty?
    send_request Net::HTTP::Get.new(@uri.request_uri, @header)
  end

  def post(url, params = {})
    @uri = URI($base_api_uri + url)
    request = Net::HTTP::Post.new(@uri, @header)
    request.body = params.to_json
    send_request request
  end

  def put(url, params = {})
    @uri = URI($base_api_uri + url)
    request = Net::HTTP::Put.new(@uri, @header)
    request.body = params.to_json
    send_request request
  end

  def delete(url)
    @uri = URI($base_api_uri + url)
    send_request Net::HTTP::Delete.new(@uri, @header)
  end

  def send_request(request)
    begin
      handle_response @http.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPUnauthorized,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, Errno::ECONNREFUSED => e
      raise e
    end
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess then
      JSON.parse(response.read_body)
    else
      response.value
    end
  end
end
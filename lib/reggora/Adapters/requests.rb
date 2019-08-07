class Requests
  def initialize(auth_token, integration_token, type)
    @uri = URI("#{$base_api_uri}#{type}")
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
    @header = {"Content-Type" => 'application/json', "Authorization" => "Bearer #{auth_token}", "integration" => integration_token}
  end

  def full_uri(path)
    URI("#{@uri.to_s}#{path}")
  end

  def get(url, params = {})
    api_endpoint = full_uri url
    api_endpoint.query = URI.encode_www_form(params) unless params.empty?
    send_request Net::HTTP::Get.new(api_endpoint.request_uri, @header)
  end

  def post(url, params = {})
    api_endpoint = full_uri url
    request = Net::HTTP::Post.new(api_endpoint, @header)
    request.body = params.to_json
    send_request request
  end

  def put(url, params = {})
    api_endpoint = full_uri url
    request = Net::HTTP::Put.new(api_endpoint, @header)
    request.body = params.to_json
    send_request request
  end

  def delete(url)
    api_endpoint = full_uri url
    send_request Net::HTTP::Delete.new(api_endpoint, @header)
  end

  def send_request(request)
    begin
      handle_response @http.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPUnauthorized,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, Errno::ECONNREFUSED => e
      raise e.inspect
    end
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess then
      JSON.parse(response.read_body)
    when Net::HTTPBadRequest then
      raise JSON.parse(response.read_body).inspect
    else
      raise JSON.parse(response.read_body).inspect
    end
  end
end
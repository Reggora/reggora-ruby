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

  def post(url, params = {}, query_params = {})
    api_endpoint = full_uri url
    api_endpoint.query = URI.encode_www_form(query_params) unless query_params.empty?
    request = Net::HTTP::Post.new(api_endpoint, @header)
    request.body = params.to_json
    send_request request
  end

  def post_file(url, params)
    api_endpoint = full_uri url
    boundary = "AaB03x"
    header = {"Content-Type" => "multipart/form-data, boundary=#{boundary}", "Authorization" => "Bearer #{@header['Authorization']}", "integration" => @header['integration']}
    # We're going to compile all the parts of the body into an array, then join them into one single string
    # This method reads the given file into memory all at once, thus it might not work well for large files
    post_body = []
    file = params[:file]
    # Add the file Data
    post_body << "--#{boundary}\r\n"
    post_body << "Content-Disposition: form-data; name=\"file\"; filename=\"#{ params[:file_name] || File.basename(file)}\"\r\n"
    post_body << "Content-Type: #{MIME::Types.type_for(file)}\r\n\r\n"
    post_body << File.open(file, 'rb') { |io| io.read }

    # Add the JSON
    post_body << "--#{boundary}\r\n"
    post_body << "Content-Disposition: form-data; name=\"id\"\r\n\r\n"
    post_body << params[:id]
    post_body << "\r\n\r\n--#{boundary}--\r\n"
    request = Net::HTTP::Post.new(api_endpoint, header)
    request.body = post_body.to_json
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
      json_parse(response.read_body)
    when Net::HTTPBadRequest then
      res = json_parse(response.read_body)
      raise res.inspect if res["error"].nil?
      res
    when Net::HTTPInternalServerError then
      raise "Internal server error"
    else
      raise "Unknown error #{response}: #{response.inspect}"
    end
  end

  def json_parse(res)
    begin
      JSON.parse(res)
    rescue JSON::ParserError
      res
    end
  end
end
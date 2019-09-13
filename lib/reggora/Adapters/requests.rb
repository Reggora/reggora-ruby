require 'mime/types'
module Reggora
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
      header = @header.dup
      boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
      header["Content-Type"] = "multipart/form-data; boundary=#{boundary}"

      request = Net::HTTP::Post.new(api_endpoint, header)
      request.body = ""
      params.each do |k, v|
        if k.to_s == 'file'
          mime_type = MIME::Types.type_for(v)
          request.body += "--#{boundary}\r\nContent-Disposition: form-data; name=\"#{k.to_s}\"; filename=\"#{v}\"\r\nContent-Type: #{mime_type[0]}\r\n"
        else
          request.body += "--#{boundary}\r\nContent-Disposition: form-data; name=\"#{k.to_s}\"\r\n\r\n#{v}\r\n"
        end
      end

      request.body += "\r\n\r\n--#{boundary}--"
      send_request request

    end

    def put(url, params = {})
      api_endpoint = full_uri url
      request = Net::HTTP::Put.new(api_endpoint, @header)
      request.body = params.to_json
      send_request request
    end

    def delete(url, params = {})
      api_endpoint = full_uri url
      request = Net::HTTP::Delete.new(api_endpoint, @header)
      request.body = params.to_json
      send_request request
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
      print "\n------ Response -----\n"
      puts response.read_body
      print "---------------------------"
      case response
      when Net::HTTPSuccess then
        json_parse(response.read_body)
      when Net::HTTPBadRequest then
        res = json_parse(response.read_body)
        raise res.inspect if res["error"].nil?
        res
      when Net::HTTPUnauthorized then
        raise "Unauthorized."
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
end
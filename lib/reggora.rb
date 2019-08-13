# frozen_string_literal: true
require_relative 'reggora/Adapters/api_client'
require_relative 'reggora/Adapters/requests'
Dir[File.join(__dir__, 'reggora', 'Entity', 'Lender', '*.rb')].each do |f|
  require f
end

module Reggora

  class LenderApiClient

    # @param [String] username
    # @param [String] password
    # @param [String] integration_token
    def initialize(username, password, integration_token)
      authorization = ApiClient.authenticate(username, password, 'lender')
      @api_client = Requests.new(authorization["token"], integration_token, 'lender')
    end

    # @param [string] username
    # @param [string] password
    def self.authenticate(username, password)
      ApiClient.authenticate(username, password, 'lender')
    end

    def get(url, params = {})
      @api_client.get(url, params)
    end

    def post(url, params = {}, query_params = {})
      @api_client.post(url, params, query_params)
    end

    def post_file(url, params = {})
      @api_client.post_file(url, params)
    end

    def put(url, params = {})
      @api_client.put(url, params)
    end

    def delete(url, params =  {})
      @api_client.delete(url, params)
    end

  end

  class VendorApiClient
    def initialize(username, password, integration_token)
      authorization = ApiClient.authenticate(username, password, 'vendor')
      @api_client = Requests.new(authorization["token"], integration_token, 'vendor')
    #  Todo
    end
  end

end


# frozen_string_literal: true
require_relative 'reggora/Entity/Lender/loan'
require_relative 'reggora/Entity/Lender/order'
require_relative 'reggora/Entity/Lender/evault'
require_relative 'reggora/Adapters/lender_api_client'
module Reggora
  # class Error < StandardError; end

  class Lender
    def initialize(user_name, password, integration_token)
      LenderApiClient.new(user_name, password, integration_token)
    end
  end

  class Vendor
    def initialize(user_name, password, integration_token)
    #  Todo
    end
  end

end


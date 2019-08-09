# frozen_string_literal: true
require_relative 'reggora/Entity/Lender/loan'
require_relative 'reggora/Entity/Lender/order'
require_relative 'reggora/Entity/Lender/evault'
require_relative 'reggora/Entity/Lender/product'
require_relative 'reggora/Entity/Lender/submission'
require_relative 'reggora/Entity/Lender/user'
require_relative 'reggora/Entity/Lender/vendor'
require_relative 'reggora/Entity/Lender/schedule_payment_app'
require_relative 'reggora/Adapters/lender_api_client'

# init api client

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


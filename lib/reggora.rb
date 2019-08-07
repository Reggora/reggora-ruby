# frozen_string_literal: true
module Reggora
  # class Error < StandardError; end
  # Your code goes here...

  require 'reggora/Adapters/api_client'
  require 'reggora/Adapters/lender_api_client'
  require 'reggora/Entity/Lender/loan'
  @aa = LenderApiClient.new('jake@reggora.com', 'reggora123', '906414c6-29f3-4c96-8deb-bbc2f4616275')
  loans = @aa.get('/loans')
  aa = dd
end


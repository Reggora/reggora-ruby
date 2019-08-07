class LenderApiClient < ApiClient

  # @param [String] username
  # @param [String] password
  # @param [String] integration_token
  def initialize(username, password, integration_token)
    authorization = ApiClient.authenticate(username, password, 'lender')
    @api_client = super(authorization["token"], integration_token, 'lender')
  end

  # @param [string] username
  # @param [string] password
  # @return [Hash] authentication token
  def self.authenticate(username, password)
    ApiClient.authenticate(username, password, 'lender')
  end

  def get(url, params = {})
    @api_client.get(url, params)
  end

  def post(url, params = {})
    @api_client.post(url, params)
  end

  def put(url, params = {})
    @api_client.put(url, params)
  end

  def delete(url)
    @api_client.delete(url)
  end
end
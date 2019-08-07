class LenderApiClient < ApiClient

  # @param [String] email
  # @param [String] password
  # @param [String] integration_token
  def initialize(email, password, integration_token)
    authorization = ApiClient.authenticate(email, password, 'lender')
    @api_client = super(authorization[:token], integration_token, 'lender')
  end

  # @param [string] email
  # @param [string] password
  # @return [Hash] authentication token
  def self.authenticate(email, password)
    ApiClient.authenticate(email, password, 'lender')
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
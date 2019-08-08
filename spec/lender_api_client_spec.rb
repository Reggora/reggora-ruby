RSpec.describe LenderApiClient do
  it 'Login to Reggora to get auth_token' do
    response = LenderApiClient.authenticate($user_name, $password)
    expect(response).to have_key("token")
  end
  it 'Initialize LenderApiClient' do
    @lender_api_client = LenderApiClient.new($user_name, $password, $int_token)
    expect(@lender_api_client).to be_an_kind_of(LenderApiClient)
  end
end
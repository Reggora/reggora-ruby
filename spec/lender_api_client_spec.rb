RSpec.describe Reggora::LenderApiClient do
  it 'Login to Reggora to get auth_token' do
    response = Reggora::LenderApiClient.authenticate($user_name, $password)
    expect(response).to have_key("token")
  end
  it 'Initialize LenderApiClient' do
    @lender_api_client = Reggora::LenderApiClient.new($user_name, $password, $int_token)
    expect(@lender_api_client).to be_an_kind_of(Reggora::LenderApiClient)
  end
end
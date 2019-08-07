RSpec.describe LenderApiClient do
  let(:user_name){'jake@reggora.com'}
  let(:password){'reggora123'}
  let(:int_token){'906414c6-29f3-4c96-8deb-bbc2f4616275'}
  it 'Login to Reggora to get auth_token' do
    response = LenderApiClient.authenticate(user_name, password)
    expect(response).to have_key("token")
  end
  it 'Initialize LenderApiClient' do
    @lender_api_client = LenderApiClient.new(user_name, password, int_token)
    expect(@lender_api_client).to be_an_kind_of(LenderApiClient)
  end
end
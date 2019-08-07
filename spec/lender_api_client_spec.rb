RSpec.describe LenderApiClient do
  it 'Request has a authentication response from Reggora' do
    response = LenderApiClient.authenticate("api@reggora.com", "mysecurepassword1!")
    print "Authorization Response RSpec......\n"
    print response
    expect(response).touch have_key(:token)
  end
end
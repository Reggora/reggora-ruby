RSpec.describe Loan do
  @lender_api_client = LenderApiClient.new('jake@reggora.com', 'reggora123', '906414c6-29f3-4c96-8deb-bbc2f4616275')
  describe "GET All Loans" do
    @loans = @lender_api_client.get('/loans')
    it "JSON body response has data" do
      expect(@loans).to have_key("data")
    end
    it "JSON body response has Loans" do
      expect(@loans["data"]).to have_key(["loans"])
    end
    it "JSON body response has a Loan at least" do
      expect(@loans["data"]["loans"]).not_to be_empty
    end
    it "JSON body response contains expected Loan attributes" do
      expect(@loans["data"]["loans"].first).to match_array(["id", "loan_number", "loan_officer", "appraisal_type", "due_date", "created", "updated", "related_order", "subject_property_address", "subject_property_city", "subject_property_state", "subject_property_zip", "case_number", "loan_type"])
    end
  end
end
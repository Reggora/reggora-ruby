RSpec.describe Loan do

  before do
    @_loan = Loan.new
  end

  describe "Get All Loans" do
    before do
      query_params =  {
          'offset': 0,
          'limit': 10,
          'ordering': '-created',
          'loan_officer': '5b5b19d3c643b3000f8f2857'
      }
      @loans = @_loan.all(query_params)
    end

    it "returns http success" do
      expect(@loans["status"]).to eq(200)
    end

    it "JSON body response has a Loan at least" do
      expect(@loans["data"]).not_to be_nil
    end

  end

  describe "Get a Loan" do
    before do
      @test_loan = @_loan.create(@_loan.sample_data)
      @loan = @_loan.find(@test_loan["data"])
    end

    it "returns http success" do
      expect(@loan["stauts"]).to eq(200)
    end

    it "JSON body response has a Loan" do
      expect(@loan["data"]).not_to be_empty
    end

    it "JSON body response contains expected Loan attributes" do
      expect(@loan["data"].keys).to match_array(["id", "loan_number", "loan_officer", "appraisal_type", "due_date", "created", "updated", "related_order", "subject_property_address", "subject_property_city", "subject_property_state", "subject_property_zip", "case_number", "loan_type"])
    end
  end

  describe "Create a Loan" do
    before do
      @loan = @_loan.create(@_loan.sample_data)
    end

    it "returns http success" do
      expect(@loan["status"]).to eq(200)
    end

    it "JSON body response has id of the new Loan" do
      expect(@loan["data"]).not_to be_empty
    end

  end

  describe "Edit a Loan" do
    before do
      @loan_for_test = @_loan.create(@_loan.sample_data)
      @test_loan = @_loan.find(@loan_for_test["data"])
      @loan = @_loan.edit(@test_loan["data"]["id"], @_loan.sample_data)
    end

    it "returns http success" do
      expect(@loan["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Loan" do
      expect(@loan["data"]).not_to be_empty
    end

    it "Loan number should be updated" do
      @updated_loan = @_loan.find(@loan["data"])
      expect(@updated_loan["data"]["id"]).to eq(@test_loan["data"])
      expect(@updated_loan["data"]["loan_number"]).not_to eq(@test_loan["data"]["loan_number"])
    end

  end

  describe "Delete a Loan" do
    before do
      @test_loan = @_loan.create(@_loan.sample_data)
      @response = @_loan.delete(@test_loan["data"])
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end
    it "should not return deleted loan" do
      @deleted_loan_resp = @_loan.find(@test_loan["data"])
      expect(@deleted_loan_resp).to have_key("error")
    end
  end
end
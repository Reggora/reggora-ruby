RSpec.describe Loan do

  before do
    @_loan = Loan.new($lender_api_client)
    @model = 'loan'
  end

  describe "Get All Loans" do
    before do
      @loans = @_loan.all
    end

    it "returns http success" do
      expect(@loans["status"]).to eq(200)
    end

    it "JSON body response has a Loan at least" do
      expect(@loans["data"]["#{@model}s"]).not_to be_nil
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
      expect(@loan["data"][@model]).not_to be_empty
    end

    it "JSON body response contains expected Loan attributes" do
      loan_attributes = %w(id loan_number loan_officer appraisal_type due_date created updated related_order subject_property_address subject_property_city subject_property_state subject_property_zip case_number loan_type)
      expect(@loan["data"][@model].keys).to match_array(loan_attributes)
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
      @loan = @_loan.edit(@test_loan["data"][@model]["id"], {"case_number": "10030MA"})
    end

    it "returns http success" do
      expect(@loan["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Loan" do
      expect(@loan["data"]).not_to be_empty
    end

    it "Case number should be updated" do
      @updated_loan = @_loan.find(@loan["data"])
      expect(@updated_loan["data"][@model]["id"]).to eq(@test_loan["data"][@model]["id"])
      expect(@updated_loan["data"][@model]["case_number"]).not_to eq(@test_loan["data"][@model]["case_number"])
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
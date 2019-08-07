require_relative '../lib/reggora/Entity/Lender/loan'
RSpec.describe Loan do

  describe "Get All Loans" do
    before do
      query_params =  {
          'offset': 0,
          'limit': 10,
          'ordering': '-created',
          'loan_officer': '5b5b19d3c643b3000f8f2857'
      }
      @loans = Loan.new.all(query_params)
    end

    it "returns http success" do
      expect(@loans["status"]).to eq(200)
    end

    it "JSON body response has data" do
      expect(@loans).to have_key("data")
    end
    it "JSON body response has a Loan at least" do
      expect(@loans["data"]).not_to be_empty
    end

    it "JSON body response contains expected Loan attributes" do
      expect(@loans["data"].first.keys).to match_array(["id", "loan_number", "loan_officer", "appraisal_type", "due_date", "created", "updated", "related_order", "subject_property_address", "subject_property_city", "subject_property_state", "subject_property_zip", "case_number", "loan_type"])
    end
  end

  describe "Get a Loan" do
    before do
      @loan = Loan.new.find("5d4b3683c92c89000cd8dc7c")
    end

    it "returns http success" do
      expect(@loan["status"]).to eq(200)
    end

    it "JSON body response has data" do
      expect(@loan).to have_key("data")
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
      loan_params = {
          "loan_number": "12352",
          "loan_officer": "",
          "appraisal_type": "Refinance",
          "due_date": Time.now.strftime("%Y-%m-%d %H:%M:%S"),
          "subject_property_address": "100 Mass Ave",
          "subject_property_city": "Boston",
          "subject_property_state": "MA",
          "subject_property_zip": "02192",
          "case_number": "10029MA",
          "loan_type": "FHA"
      }
      @loan = Loan.new.create(loan_params)
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
      loan_params = {
          "loan_number": "12352",
          "loan_officer": "",
          "appraisal_type": "Refinance",
          "due_date": Time.now.strftime("%Y-%m-%d %H:%M:%S"),
          "subject_property_address": "100 Mass Ave",
          "subject_property_city": "Boston",
          "subject_property_state": "MA",
          "subject_property_zip": "02192",
          "case_number": "10029MA",
          "loan_type": "FHA"
      }
      @loan = Loan.new.edit('5d4b3683c92c89000cd8dc7c', loan_params)
    end

    it "returns http success" do
      expect(@loan["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Loan" do
      expect(@loan["data"]).not_to be_empty
    end

    it "Due date was updated" do
      @new_loan = Loan.new.find('5d4b3683c92c89000cd8dc7c')
      expect(@loan["data"]["due_date"]).not_to eq(Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    end

  end

  describe "Delete a Loan" do
    before do
      @response = Loan.new.delete("5d4b3653c92c89000e3f3197")
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
      expect(@response["data"].downcase.strip).to include('loan deleted.')
    end

  end
end
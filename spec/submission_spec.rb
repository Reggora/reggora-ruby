RSpec.describe Reggora::Submission do
  before do
    @_submission = Reggora::Submission.new($lender_api_client)
    @model = 'submission'
    @_order = Reggora::Order.new($lender_api_client)
    @_loan = Reggora::Loan.new($lender_api_client)
    @_product = Reggora::Product.new($lender_api_client)

    @test_loan = @_loan.create(@_loan.sample_data)
    @test_product = @_product.create(@_product.sample_data)
    @order_seed_data = @_order.sample_data(@test_loan["data"], @test_product["data"])[:auto_allocation_type]

    @order = @_order.create(@order_seed_data)
    @test_order_id = @order["data"]
  end
  describe "Get All Submissions associated with an order." do
    before do
      @submissions = @_submission.all(@test_order_id)
    end

    it "returns http success" do
      expect(@submissions["status"]).to eq(200)
    end

    it "JSON body response has a Submission at least" do
      expect(@submissions["data"]["#{@model}s"]).not_to be_empty
    end
  end

  describe "Download Submission Document" do
    before do
      version = 1
      report_type = 'pdf_report' # 'xml_report', invoice
      @submission = @_submission.download_submission_doc(@test_order_id, version, report_type)
    end

    it "returns http success" do
      expect(@submission["error"]).to be_empty
    end

  end
end


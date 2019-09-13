RSpec.describe Reggora::Order do

  before do
    @_order = Reggora::Order.new($lender_api_client)
    @_loan = Reggora::Loan.new($lender_api_client)
    @_product = Reggora::Product.new($lender_api_client)
    @model = 'order'
    @test_loan = @_loan.create(@_loan.sample_data)
    @test_product = @_product.create(@_product.sample_data)
    # binding.pry
    @order_seed_data = @_order.sample_data(@test_loan["data"], @test_product["data"])[:auto_allocation_type]
    test_order = @_order.create(@order_seed_data)
    @test_order = @_order.find(test_order["data"])
    @test_order_id = @test_order["data"][@model]["id"]
  end

  describe "Get All Orders" do
    before do
      # binding.pry
      @orders = @_order.all
    end

    it "returns http success" do
      expect(@orders["status"]).to eq(200)
    end

    it "JSON body response has an Order at least" do
      expect(@orders["data"]["#{@model}s"]).not_to be_nil
    end

  end

  describe "Get an Order" do
    before do
      # binding.pry
      @order = @_order.find(@test_order_id)
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has an Order" do
      expect(@order["data"][@model]).not_to be_empty
    end

    it "JSON body response contains expected Order attributes" do
      order_attributes = %w(id status priority due_date evault inspection_date accepted_vendor created allocation_mode requested_vendors inspection_complete products loan_file)
      expect(@order["data"][@model].keys).to match_array(order_attributes)
    end
  end

  describe "Create an Order" do
    before do
      # binding.pry
      test_loan = @_loan.create(@_loan.sample_data)
      test_product = @_product.create(@_product.sample_data)
      order_seed_data = @_order.sample_data(test_loan["data"], test_product["data"])[:auto_allocation_type]
      @order = @_order.create(order_seed_data)
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has id of the new Order" do
      expect(@order["data"]).not_to be_empty
    end

  end

  describe "Edit an Order" do
    before do
      # binding.pry
      @order = @_order.edit(@test_order_id, @order_seed_data)
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Order" do
      expect(@order["data"]).not_to be_empty
    end

    it "Due date should be updated" do
      @updated_order = @_order.find(@order["data"])
      expect(@updated_order["data"][@model]["id"]).to eq(@test_order_id)
      expect(@updated_order["data"][@model]["due_date"]).not_to eq(@test_order["data"]["due_date"])
    end

  end

  describe "Cancel an Order" do
    before do
      # binding.pry
      @response = @_order.cancel(@test_order_id)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end

    it "Cancelled order should have status 'Canceled'" do
      @deleted_order = @_order.find(@test_order_id)
      expect(@deleted_order["data"][@model]["status"].downcase).to eq("canceled")
    end
  end

  describe "Place Order On Hold" do
    before do
      # binding.pry
      reason = 'I\'d like to wait to start this order.'
      @response = @_order.place_on_hold(@test_order_id, reason)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response["data"]).not_to be_empty
    end
  end

  describe "Remove Order HoldPlace Order On Hold" do
    before do
      # binding.pry
      @response = @_order.remove_from_hold(@test_order_id)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response["data"]).not_to be_empty
    end
  end
end
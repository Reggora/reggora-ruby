RSpec.describe Order do

  before do
    @_order = Order.new
  end

  describe "Get All Orders" do
    before do
      query_params =  {
          'offset': 0,
          'ordering': '-created',
          'loan_officer': '5b5b19d3c643b3000f8f2857',
          'filter': 'rush, behind_schedule'
      }
      @orders = @_order.all(query_params)
    end

    it "returns http success" do
      expect(@orders["status"]).to eq(200)
    end

    it "JSON body response has an Order at least" do
      expect(@orders["data"]).not_to be_nil
    end

  end

  describe "Get an Order" do
    before do
      @test_order = @_order.create(@_order.sample_data[:manual_allocation_type])
      @order = @_order.find(@test_order["data"]["id"])
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has an Order" do
      expect(@order["data"]).not_to be_empty
    end

    it "JSON body response contains expected Order attributes" do
      expect(@order["data"].keys).to match_array(["id", "status", "priority", "due_date", "inspection_date", "accepted_vendor", "created", "allocation_mode", "requested_vendors", "inspection_complete", "products", "loan_file"])
    end
  end

  describe "Create an Order" do
    before do
      @order = @_order.create(@_order.sample_data[:manual_allocation_type])
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
      @test_order = @_order.create(@_order.sample_data[:manual_allocation_type])
      @order = @_order.edit(@test_order["data"]["id"], @_order.sample_data[:manual_allocation_type])
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Order" do
      expect(@order["data"]).not_to be_empty
    end

    it "Due date should be updated" do
      @updated_order = @_order.find(@order["data"]["id"])
      expect(@updated_order["data"]["id"]).to eq(@test_order["data"]["id"])
      expect(@updated_order["data"]["due_date"]).not_to eq(@test_order["data"]["due_date"])
    end

  end

  describe "Cancel an Order" do
    before do
      @test_order = @_order.create(@_order.sample_data[:manual_allocation_type])
      @response = @_order.cancel(@test_order["data"]["id"])
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end

    it "should not return deleted order" do
      @deleted_order_resp = @_order.find(@test_order["data"]["id"])
      expect(@deleted_order_resp).to have_key("error")
    end
  end
end
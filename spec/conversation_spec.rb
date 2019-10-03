RSpec.describe Reggora::Conversation do

  before do

    @_order = Reggora::Order.new($lender_api_client)
    @_loan = Reggora::Loan.new($lender_api_client)
    @_product = Reggora::Product.new($lender_api_client)
    @_vendor = Reggora::Vendor.new($lender_api_client)
    @_conversation = Reggora::Conversation.new($lender_api_client)
    @model = "conversation"
    
    test_vendors = @_vendor.all
    test_vendor_id = test_vendors["data"]["vendors"].first["id"]
    test_loan = @_loan.create(@_loan.sample_data)
    test_product = @_product.create(@_product.sample_data)
    order_seed_data = @_order.sample_data(test_loan["data"], test_product["data"], [test_vendor_id])[:manual_allocation_type]
    test_order_id = @_order.create(order_seed_data)
    test_order = @_order.find(test_order_id['data'])
    @test_conversation_id = test_order["data"]['order']["conversation"]
  end

  describe "Send Message" do
    before do
      message_params = {
        "message": "Hi there!"
      }
      @message = @_conversation.send_message(@test_conversation_id, message_params)
      @conversation = @_conversation.find_by_id(@test_conversation_id)
    end
    it "returns http success" do
      expect(@message["status"]).to eq(200)
    end

    it "JSON body response has id of the conversation" do
      expect(@message["data"]).not_to be_empty
    end

    it "JSON body response has a conversation object" do
      expect(@conversation["data"][@model].keys).to match_array(["id", "order_id", "messages"])
    end

    it "JSON body response has at least one message" do
      expect(@conversation["data"][@model]["messages"]).not_to be_empty
    end
    
    it "JSON body response contains messages" do
      expect(@conversation["data"][@model]["messages"].first.keys).to match_array(["id", "message", "sender", "sent_time"])
    end
  end

  describe "Get Conversation by ID" do
    before do
      @conversation = @_conversation.find_by_id(@test_conversation_id)
    end

    it "returns http success" do
      expect(@conversation["status"]).to eq(200)
    end
  end

end
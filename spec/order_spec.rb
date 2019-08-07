require_relative '../lib/reggora/Entity/Lender/order'
RSpec.describe Order do

  describe "Get All Orders" do
    before do
      query_params =  {

      }
      @orders = Order.new.all(query_params)
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
      @order = Order.new.find("5c2e718cb61f76001adf9871")
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
      order_params_manually = {
          'allocation_type': 'manually',
          'vendors': [
              '5b55d4c68d9472000fc432ef',
              '5b55d4c68d9472000fc432eg',
              '5b55d4c68d9472000fc432eh'
          ],
          'loan': '5d4b3683c92c89000cd8dc7c',
          'priority': 'Rush',
          'products': ['5b55d4c68d9472000fc432ef'],
          'due_date': '2018-12-24 21:00:00',
          'additional_fees': [
              {
                  'description': 'Large yard',
                  'amount': '50'
              },
              {
                  'description': 'Outside regular locations',
                  'amount': '20'
              }
          ]

      }
      order_params_automatically = {
          'allocation_type': 'automatically',
          'loan': '5d4b3683c92c89000cd8dc7c',
          'priority': 'Rush',
          'products': ['5b55d4c68d9472000fc432ef'],
          'due_date': '2018-12-24 21:00:00',
          'additional_fees': [
              {
                  'description': 'Large yard',
                  'amount': '50'
              },
              {
                  'description': 'Outside regular locations',
                  'amount': '20'
              }
          ]
      }
      @order = Order.new.create(order_params_manually)
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
      order_params = {
          'allocation_type': 'automatically',
          'loan': '5d4b3683c92c89000cd8dc7c',
          'priority': 'Rush',
          'products': ["5b55d4c68d9472000fc432ef"],
          'due_date': '2018-12-24 21:00:00',
          'additional_fees': [
              {
                  'description': 'Large yard',
                  'amount': '50'
              },
              {
                  'description': 'Outside regular locations',
                  'amount': '20'
              }
          ],
          'refresh': false,
      }
      @order = Order.new.edit('5c2e718cb61f76001adf9871', order_params)
    end

    it "returns http success" do
      expect(@order["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Order" do
      expect(@order["data"]).not_to be_empty
    end

    it "Due date was updated" do
      @new_order = Order.new.find('5d4b3683c92c89000cd8dc7c')
      expect(@new_order["data"]["due_date"]).not_to eq(Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    end

  end

  describe "Cancel an Order" do
    before do
      @response = Order.new.cancel("5c2e718cb61f76001adf9871")
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
      expect(@response["data"].downcase.strip).to include('canceled.')
    end

  end
end
RSpec.describe SchedulePaymentApp do
  before do
    @_app = SchedulePaymentApp.new
    @_order = Order.new

    @_loan = Loan.new
    @_product = Product.new

    @test_loan = @_loan.create(@_loan.sample_data)
    @test_product = @_product.create(@_product.sample_data)
    @order_seed_data = @_order.sample_data(@test_loan["data"], @test_product["data"])[:auto_allocation_type]

    @order = @_order.create(@order_seed_data)
  end
  describe "Send Payment App" do
    before do
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      @res = @_app.send_payment_app("fake#{s[1...4]}@reggora.com", @order["data"], 'manual', 'manual', '10', "Fake", "Person#{s[1...4]}")
    end

    it "returns http success" do
      expect(@res["status"]).to eq(200)
    end

    it "JSON body response has a success message" do
      print @res["data"]
      expect(@res["data"]).not_to be_nil
    end
  end

  describe "Send Scheduling App" do
    before do
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      @res = @_app.send_scheduling_app(["fake#{s[1...4]}@reggora.com"], @order["data"])
    end

    it "returns http success" do
      expect(@res["status"]).to eq(200)
    end

    it "JSON body response has a success message" do
      print @res["data"]
      expect(@res["data"]).not_to be_nil
    end
  end

  describe "Consumer Application Link" do
    before do
      consumer_id = 'eb402ec3-0bf4-465d-b95e-8bce612ad2be'
      link_type = 'both' # payment/schedule/both
      @res = @_app.consumer_app_link(@order["data"], consumer_id, link_type)
    end

    it "returns http success" do
      expect(@res["error"]).to be_nil
    end

    it "JSON body response has a App Link" do
      print @res
      expect(@res).not_to be_nil
      expect(@res).to include('http')
    end
  end
end

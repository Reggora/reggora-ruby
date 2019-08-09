RSpec.describe Vendor do
  before do
    @_vendor = Vendor.new
    @model = 'vendor'
    @vendors = @_vendor.all
    @test_vendor = @_vendor.find(@vendors["data"]["#{@model}s"].first["id"])
    @test_vendor_id = @test_vendor["data"]["#{@model}"]["id"]
  end
  describe "Get All Vendors in the requesting lender" do
    before do
      @vendors = @_vendor.all
    end

    it "returns http success" do
      expect(@vendors["status"]).to eq(200)
    end

    it "JSON body response has a Vendor" do
      expect(@vendors["data"]["#{@model}s"]).not_to be_nil
    end
  end

  describe "Get Vendors by zone" do
    before do
      zones = ['02806', '02807', '03102']
      @vendors = @_vendor.find_by_zone(zones)
    end

    it "returns http success" do
      expect(@vendors["status"]).to eq(200)
    end

    it "JSON body response has a Vendor" do
      expect(@vendors["data"]).not_to be_nil
    end
  end

  describe "Get Vendors by branch" do
    before do
      @vendors = @_vendor.find_by_branch("5b58c8861e5f59000d4542af")
    end

    it "returns http success" do
      expect(@vendors["status"]).to eq(200)
    end

    it "JSON body response has a Vendor" do
      expect(@vendors["data"]).not_to be_nil
    end
  end

  describe "Get Vendors by ID" do
    before do
      @vendors = @_vendor.all
      @vendor_id = @vendors["data"]["#{@model}s"].first["id"]
      @vendor = @_vendor.find(@vendor_id)
    end

    it "returns http success" do
      expect(@vendor["status"]).to eq(200)
    end

    it "JSON body response has a Vendor" do
      expect(@vendor["data"]).not_to be_nil
    end

    it "JSON body response contains expected Vendor ID" do
      expect(@vendor["data"]["#{@model}"]["id"]).to eq(@vendor_id)
    end
  end

  # describe "Invite a vendor to lender" do
  #   before do
  #     s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  #     @res = @_vendor.invite("FakeFirm#{s[1..3]}", "Fake", "Person#{s[1...4]}", "fake#{s[1...4]}@reggora.com", "#{rand(100000...99999)}")
  #   end
  #
  #   it "returns http success" do
  #     expect(@res["status"]).to eq(200)
  #   end
  #
  #   it "JSON body response has a User" do
  #     expect(@res["data"]).not_to eq("")
  #   end
  # end

  describe "Edit/Update a Vendor" do
    before do
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      @vendors = @_vendor.all
      @update_vendor_params = @_vendor.vendor_params("FakeFirm#{s[1..3]}", "Fake", "Person#{s[1...4]}", "#{rand(100000...99999)}")
      @vendor = @_vendor.edit(@test_vendor_id, @update_vendor_params)
    end

    it "returns http success" do
      expect(@vendor["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Vendor" do
      expect(@vendor["data"]).not_to be_empty
    end

    it "JSON body response has the revised Vendor firm name" do
      @updated_vendor = @_vendor.find(@vendor["data"])
      expect(@updated_vendor["data"]["#{@model}"]["firmname"]).to eq(@update_vendor_params[:firmname])
    end
  end

  describe "Delete a Vendor" do
    before do
      @response = @_vendor.delete(@test_vendor_id)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end

    it "should not return deleted vendor" do
      @deleted_vendor = @_vendor.find(@test_vendor_id)
      expect(@deleted_vendor["data"]["#{@model}"]["is_deleted"]).to eq(true)
    end
  end
end

RSpec.describe Product do
  before do
    @_product = Product.new($lender_api_client)
    @model = 'product'

    @test_product = @_product.create(@_product.sample_data)
    @test_product_id = @test_product["data"]
  end
  describe "Get All Products" do
    before do
      @products = @_product.all
    end

    it "returns http success" do
      expect(@products["status"]).to eq(200)
    end

    it "JSON body response has a Loan at least" do
      expect(@products["data"]["#{@model}s"]).not_to be_nil
    end

  end

  describe "Get a Product" do
    before do
      @product = @_product.find(@test_product_id)
    end

    it "returns http success" do
      expect(@product["status"]).to eq(200)
    end

    it "JSON body response has a Product" do
      expect(@product["data"][@model]).not_to be_empty
    end

    it "JSON body response contains expected Loan attributes" do
      product_attributes = %w(id product_name amount inspection_type requested_forms)
      expect(@product["data"][@model].keys).to match_array(product_attributes)
    end
  end

  describe "Create a Product" do
    before do
      @product = @_product.create(@_product.sample_data)
    end

    it "returns http success" do
      expect(@product["status"]).to eq(200)
    end

    it "JSON body response has id of the new Product" do
      expect(@product["data"]).not_to be_empty
    end

  end

  describe "Edit a Product" do
    before do
      @product_params = @_product.sample_data
      @product = @_product.edit(@test_product_id, @product_params)
    end

    it "returns http success" do
      expect(@product["status"]).to eq(200)
    end

    it "JSON body response has id of the updated Product" do
      expect(@product["data"]).not_to be_empty
    end

    it "JSON body response has the revised product name" do
      @updated_product = @_product.find(@product["data"])
      expect(@updated_product["data"][@model]["product_name"]).to eq(@product_params[:product_name])
    end

  end

  describe "Delete a Product" do
    before do
      @response = @_product.delete(@test_product_id)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end

    it "should not return deleted product" do
      @deleted_product_resp = @_product.find(@test_product_id)
      expect(@deleted_product_resp).to have_key("error")
    end
  end
end
RSpec.describe Reggora::User do
  before do
    @_user = Reggora::User.new($lender_api_client)
    @model = 'user'
    @test_user = @_user.create(@_user.sample_data)
    @test_user_id = @test_user["data"]
  end
  describe "Get All Users in the requesting lender" do
    before do
      @users = @_user.all(@_user.query_params)
    end

    it "returns http success" do
      expect(@users["status"]).to eq(200)
    end

    it "JSON body response has a User at least" do
      expect(@users["data"]).not_to be_nil
    end
  end

  describe "Get a User" do
    before do
      users = @_user.all(@_user.query_params)
      @user = @_user.find(users["data"].first["id"])
    end

    it "returns http success" do
      expect(@user["status"]).to eq(200)
    end

    it "JSON body response has a User" do
      expect(@user["data"]).not_to be_empty
    end

    it "JSON body response contains expected User attributes" do
      user_attributes = %w(id email phone_number cell_number firstname lastname nmls_id created matched_users role)
      expect(@user["data"].keys).to match_array(user_attributes)
    end
  end

  describe "Invite a User to platform" do
    before do
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      @res = @_user.invite("fake#{s[1...4]}@reggora.com", "Admin", "Fake", "Person#{s[1...4]}", "#{rand(100000...99999)}")
    end

    it "returns http success" do
      expect(@res["status"]).to eq(200)
    end

    it "JSON body response has a User" do
      expect(@res["data"]).not_to eq("")
    end
  end

  describe "Create a User" do
    before do
      @user = @_user.create(@_user.sample_data)
    end

    it "returns http success" do
      expect(@user["status"]).to eq(200)
    end

    it "JSON body response has id of the new Product" do
      expect(@user["data"]).not_to be_empty
    end
  end

  describe "Edit/Update a User" do
    before do
      @update_user_params = @_user.sample_data
      @user = @_user.edit(@test_user_id, @update_user_params)
    end

    it "returns http success" do
      expect(@user["status"]).to eq(200)
    end

    it "JSON body response has id of the updated User" do
      expect(@user["data"]).not_to be_empty
    end

    it "JSON body response has the revised User last name" do
      @updated_user = @_user.find(@user["data"])
      expect(@updated_user["data"]["lastname"]).to eq(@update_user_params[:lastname])
    end
  end

  describe "Delete a User" do
    before do
      @response = @_user.delete(@test_user_id)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
    end

    it "should not return deleted user" do
      @deleted_user_resp = @_user.find(@test_user_id)
      expect(@deleted_user_resp).to have_key("error")
    end
  end

end


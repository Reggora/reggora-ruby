RSpec.describe Reggora::Evault do

  before do
    @_evault = Reggora::Evault.new($lender_api_client)
    @model = 'evault'
    @test_order_id = "5d4d06d6d28c2600109499c5"
    @file = "#{File.expand_path(File.dirname(__FILE__))}/files/sample.pdf"
  end
  describe "Get eVault by ID" do
    before do
      @evault = @_evault.find(@test_order_id)
    end

    it "returns http success" do
      expect(@evault["status"]).to eq(200)
    end

    it "JSON body response has a Vault object" do
      expect(@evault["data"][@model].keys).to match_array(["id", "documents"])
    end

    it "JSON body response has a document at least" do
      expect(@evault["data"][@model]["documents"]).not_to be_empty
    end

    it "JSON body response contains expected Document attributes" do
      expect(@evault["data"][@model]["documents"].first.keys).to match_array(["document_name", "document_id", "upload_datetime"])
    end
  end

  describe "Handle document request" do
    before do
      upload_params = {
          'id': @test_order_id,
          'file': @file
      }
      @document = @_evault.upload_document(upload_params)
    end
    describe "Get a Document" do
      before do
        @document = @_evault.document(@test_order_id, @document["data"])
      end

      it "returns document" do
        print "\n==== Document Begin ====\n"
        print @document
        print "\n==== Document End====\n"
      end
    end

    describe "Upload document" do
      it "returns http success" do
        expect(@document["status"]).to eq(200)
      end

      it "JSON body response has id of the document" do
        expect(@document["data"]).not_to be_empty
      end
    end

    describe "Delete a Document" do
      before do
        document_params = {
            'id': @test_order_id,
            'document_id': @document["data"],
        }
        @response = @_evault.delete_document(document_params)
      end

      it "returns http success and has success message" do
        expect(@response["status"]).to eq(200)
        expect(@response).to have_key("data")
      end
      it "should not return deleted document" do
        @response = @_evault.document(@test_order_id, @document["data"])
        expect(@response).to have_key("error")
      end
    end

  end

  describe "Upload P&S" do
    before do
      upload_params = {
          'id': '5d4d06d6d28c2600109499c4',
          'file': @file,
          'document_name': 'sample.pdf'
      }
      @ps_document = @_evault.upload_p_s(upload_params)
    end
    it "returns http success" do
      expect(@ps_document["status"]).to eq(200)
    end

    it "JSON body response has id of the document" do
      expect(@ps_document["data"]).not_to be_empty
    end
  end

end
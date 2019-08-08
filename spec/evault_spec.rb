RSpec.describe Evault do
  describe "Get eVault by ID" do
    before do
      @evault = Evault.new.find("5c4f16764672bb00105ea5f9")
    end

    it "returns http success" do
      expect(@evault["status"]).to eq(200)
    end

    it "JSON body response has a Vault object" do
      expect(@evault["data"].keys).to match_array(["id", "documents"])
    end

    it "JSON body response has a document at least" do
      expect(@evault["data"]["documents"]).not_to be_empty
    end

    it "JSON body response contains expected Document attributes" do
      expect(@evault["data"]["documents"].first.keys).to match_array(["document_name", "document_id", "upload_datetime"])
    end
  end

  # skip testing because downloading file
  describe "Get Document" do
    before do
      @document = Evault.new.document("5c4f16764672bb00105ea5f9", "24bab39a-4404-11e8-ba10-02420a050006")
    end

    it "returns http success" do
      expect(@document["status"]).to eq(200)
    end
  end

  describe "Upload document" do
    before do
      file = "#{File.expand_path(File.dirname(__FILE__))}/files/sample.pdf"
      upload_params = {
          'id': '24bab39a-4404-11e8-ba10-02420a050006',
          'file': file,
          'file_name': 'sample.pdf'
      }
      @document = Evault.new.upload_document(upload_params)
    end
    it "returns http success" do
      expect(@document["status"]).to eq(200)
    end

    it "JSON body response has id of the document" do
      expect(@document["data"]).not_to be_empty
    end
  end

  describe "Upload P&S" do
    before do
      file = "#{File.expand_path(File.dirname(__FILE__))}/files/sample.pdf"
      upload_params = {
          'id': '24bab39a-4404-11e8-ba10-02420a050006',
          'file': file,
          'file_name': 'sample.pdf'
      }
      @document = Evault.new.upload_p_s(upload_params)
    end
    it "returns http success" do
      expect(@document["status"]).to eq(200)
    end

    it "JSON body response has id of the document" do
      expect(@document["data"]).not_to be_empty
    end
  end

  describe "Delete a Document" do
    before do
      @response = Evault.new.delete_document("5c4f16764672bb00105ea5f9", "24bab39a-4404-11e8-ba10-02420a050006")
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
      expect(@response["data"].downcase.strip).to include('has been deleted.')
    end

  end
end
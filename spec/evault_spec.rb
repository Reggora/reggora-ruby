RSpec.describe Evault do

  before do
    @_evault = Evault.new
    @model = 'evault'
  end
  describe "Get eVault by ID" do
    before do
      @evault = @_evault.find("5d4d06d6d28c2600109499c5")
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

  # skip testing because downloading file
  describe "Get a  Document" do
    before do
      @document = @_evault.document("5d4d06d6d28c2600109499c5", "5172d632-ba6a-11e9-9e1d-0242ac120002")
    end

    it "returns document" do
      print "\n==== Document Begin ====\n"
      print @document
      print "\n==== Document End====\n"
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
      @document = @_evault.upload_document(upload_params)
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
          'id': '5d4d06d6d28c2600109499c4',
          'file': file,
          'file_name': 'sample.pdf'
      }
      @document = @_evault.upload_p_s(upload_params)
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
      document_params = {
          'id': '524523ff2d2d223d23',
          'document_id': '00a1eb9e-ba6a-11e9-b584-0242ac120002',
      }
      @response = @_evault.delete_document(document_params)
    end

    it "returns http success and has success message" do
      expect(@response["status"]).to eq(200)
      expect(@response).to have_key("data")
      expect(@response["data"].downcase.strip).to include('has been deleted.')
    end

  end
end
module Reggora
  class Evault
    def initialize(client)
      @model = 'evault'
      @client = client
    end
    # returns an eVault object
    def find(id)
      @client.get("/evault/#{id}")
    end

    # returns a file object specified by the evault ID and the document ID
    def document(evault_id, document_id)
      @client.get("/evault/#{evault_id}/#{document_id}")
    end

    # upload a document to an evault and returns the ID of the document
    def upload_document(upload_params)
      @client.post_file("/evault", upload_params)
    end

    # upload a P&S to an order and returns the ID of the P&S document
    def upload_p_s(upload_params)
      @client.post_file("/p_and_s", upload_params)
    end

    # delete a document from the evault
    def delete_document(params)
      @client.delete("/evault", params)
    end
  end
end
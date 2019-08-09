class Evault

  # returns an eVault object
  def find(id)
    $lender_api_client.get("/evault/#{id}")
  end

  # returns a file object specified by the evault ID and the document ID
  def document(evault_id, document_id)
    $lender_api_client.get("/evault/#{evault_id}/#{document_id}")
  end

  # upload a document to an evault and returns the ID of the document
  def upload_document(upload_params)
    $lender_api_client.post_file("/evault", upload_params)
  end

  # upload a P&S to an order and returns the ID of the P&S document
  def upload_p_s(upload_params)
    $lender_api_client.post_file("/order/p_and_s", upload_params)
  end

  # delete a document from the evault
  def delete_document(params)
    $lender_api_client.delete("/evault", params)
  end
end
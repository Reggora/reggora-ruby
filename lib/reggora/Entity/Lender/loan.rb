class Loan
  # retrieves all loans, and can take a number of query parameters
  def all(params = {})
    $lender_api_client.get('/loans', params)
  end

  # retrieves a specific loan by id
  def find(id)
    $lender_api_client.get("/loan/#{id}")
  end

  # creates a loan and returns the ID of the created loan
  def create(loan_params)
    $lender_api_client.post('/loan', loan_params)
  end

  # edits a loan and returns the ID of the edited loan. Only the provided fields will be updated
  def edit(id, loan_params)
    $lender_api_client.put("/loan/#{id}", loan_params)
  end
  # deletes a specific loan
  def delete(id)
    $lender_api_client.delete("/loan/#{id}")
  end
end
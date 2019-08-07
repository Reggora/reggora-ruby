class Loan
  def all(params = {})
    $lender_api_client.get('/loans', params)
  end

  def find(id)
    $lender_api_client.get("/loan/#{id}")
  end

  def create(loan_params)
    $lender_api_client.post('/loan', loan_params)
  end

  def edit(id, loan_params)
    $lender_api_client.put("/loan/#{id}", loan_params)
  end

  def delete(id)
    $lender_api_client.delete("/loan/#{id}")
  end
end
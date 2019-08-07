class Order
  def all(params = {})
    $lender_api_client.get('/orders', params)
  end

  def find(id)
    $lender_api_client.get("/order/#{id}")
  end

  def create(loan_params)
    $lender_api_client.post('/order', loan_params)
  end

  def edit(id, loan_params)
    $lender_api_client.put("/order/#{id}", loan_params)
  end

  def cancel(id)
    $lender_api_client.delete("/order/#{id}")
  end
end
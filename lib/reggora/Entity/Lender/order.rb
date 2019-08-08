class Order
  # retrieves all orders (limit 10 at a time). Can be filtered with query parameters
  def all(params = {})
    $lender_api_client.get('/orders', params)
  end

  # retrieves a specific order by id
  def find(id)
    $lender_api_client.get("/order/#{id}")
  end

  # creates an order and returns the ID of the created Order
  def create(loan_params)
    $lender_api_client.post('/order', loan_params)
  end

  # edits a order and returns the ID of the edited order
  def edit(id, loan_params)
    $lender_api_client.put("/order/#{id}", loan_params)
  end

  # cancels a specific order
  def cancel(id)
    $lender_api_client.delete("/order/#{id}")
  end
end
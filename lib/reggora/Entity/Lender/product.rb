class Product
  def initialize
    @model = 'product'
  end
  # retrieves all products.
  def all(params = {})
    $lender_api_client.get("/#{@model}s", params)
  end

  # retrieves a specific product by id.
  def find(id)
    $lender_api_client.get("/#{@model}/#{id}")
  end

  # creates a product and returns the ID of the created product.
  def create(loan_params)
    $lender_api_client.post("/#{@model}", loan_params)
  end

  # edits a product and returns the ID of the edited product.
  def edit(id, loan_params)
    $lender_api_client.put("/#{@model}/#{id}", loan_params)
  end
  # deletes a specific product. If an order or a loan is associated with this product the reference will not be broken.
  def delete(id)
    $lender_api_client.delete("/#{@model}/#{id}")
  end

  def sample_data
    s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    test_product_params = {
        'product_name': "Product_#{s[1...5]}",
        'amount': '100.00',
        'inspection_type': 'interior',
        'requested_forms': '1004MC, BPO'
    }
    test_product_params
  end
end
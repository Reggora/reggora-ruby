module Reggora
  class Product
    def initialize(client)
      @model = 'product'
      @client = client
    end
    # retrieves all products.
    def all(params = {})
      @client.get("/#{@model}s", params)
    end

    # retrieves a specific product by id.
    def find(id)
      @client.get("/#{@model}/#{id}")
    end

    # creates a product and returns the ID of the created product.
    def create(product_params)
      @client.post("/#{@model}", product_params)
    end

    # edits a product and returns the ID of the edited product.
    def edit(id, product_params)
      @client.put("/#{@model}/#{id}", product_params)
    end
    # deletes a specific product. If an order or a loan is associated with this product the reference will not be broken.
    def delete(id)
      @client.delete("/#{@model}/#{id}")
    end

    def sample_data
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      {
        'product_name': "Product_#{s[1...5]}",
        'amount': '100.00',
        'inspection_type': 'interior',
        'requested_forms': '1004MC, BPO'
      }
    end
  end
end
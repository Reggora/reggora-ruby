class Order

  def initialize
    @model = 'order'
  end

  # retrieves all orders (limit 10 at a time). Can be filtered with query parameters
  def all(params = {})
    $lender_api_client.get("/#{@model}s", params)
  end

  # retrieves a specific order by id
  def find(id)
    $lender_api_client.get("/#{@model}/#{id}")
  end

  # creates an order and returns the ID of the created Order
  def create(loan_params)
    $lender_api_client.post("/#{@model}", loan_params)
  end

  # edits a order and returns the ID of the edited order
  def edit(id, loan_params)
    $lender_api_client.put("/#{@model}/#{id}", loan_params)
  end

  # cancels a specific order
  def cancel(id)
    $lender_api_client.delete("/#{@model}/#{id}")
  end

  def sample_data
    order_params_manually = {
        'allocation_type': 'manually',
        'vendors': %w(5b55d4c68d9472000fc432ef 5b55d4c68d9472000fc432eg 5b55d4c68d9472000fc432eh),
        'loan': '5d4b3683c92c89000cd8dc7c',
        'priority': 'Rush',
        'products': ['5b55d4c68d9472000fc432ef'],
        'due_date': '2018-12-24 21:00:00',
        'additional_fees': [
            {
                'description': 'Large yard',
                'amount': '50'
            },
            {
                'description': 'Outside regular locations',
                'amount': '20'
            }
        ]
    }
    order_params_automatically = {
        'allocation_type': 'automatically',
        'loan': '5d4b3683c92c89000cd8dc7c',
        'priority': 'Rush',
        'products': ['5b55d4c68d9472000fc432ef'],
        'due_date': '2018-12-24 21:00:00',
        'additional_fees': [
            {
                'description': 'Large yard',
                'amount': '50'
            },
            {
                'description': 'Outside regular locations',
                'amount': '20'
            }
        ]
    }
    {:manual_allocation_type => order_params_manually, :auto_allocation_type => order_params_automatically}
  end
end
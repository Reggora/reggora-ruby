class Order

  def initialize
    @model = 'order'
  end

  # retrieves all orders (limit 10 at a time). Can be filtered with query parameters
  def all(offset = 0, limit = 0, ordering = '-created', search = '', due_in = nil, loan_officer = [], filter = '')
    $lender_api_client.get("/#{@model}s", {offset: offset, limit: limit, ordering: ordering, search: search, due_in: due_in, loan_officer: loan_officer, filter: filter})
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
    $lender_api_client.delete("/#{@model}/#{id}/cancel")
  end

  # place an active order on hold, which will disable editing and other functionality while on hold.
  def place_on_hold(order_id, reason = '')
    $lender_api_client.put("/order/#{order_id}/hold", {reason: reason})
  end

  def remove_from_hold(order_id)
    $lender_api_client.put("/order/#{order_id}/unhold")
  end

  def sample_data(loan_id, product_id)
    order_params_manually = {
        'allocation_type': 'manually',
        'loan': loan_id,
        'priority': 'Rush',
        'products': [product_id],
        'due_date': (Time.now + 60*60*24*30).strftime("%Y-%m-%d %H:%M:%S"),
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
        'loan': loan_id,
        'priority': 'Rush',
        'products': [product_id],
        'due_date': (Time.now + 60*60*24*30).strftime("%Y-%m-%d %H:%M:%S"),
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
class Loan
  def initialize
    @model = 'loan'
  end
  # retrieves all loans, and can take a number of query parameters
  def all(params = {})
    $lender_api_client.get("/#{@model}s", params)
  end

  # retrieves a specific loan by id
  def find(id)
    $lender_api_client.get("/#{@model}/#{id}")
  end

  # creates a loan and returns the ID of the created loan
  def create(loan_params)
    $lender_api_client.post("/#{@model}", loan_params)
  end

  # edits a loan and returns the ID of the edited loan. Only the provided fields will be updated
  def edit(id, loan_params)
    $lender_api_client.put("/#{@model}/#{id}", loan_params)
  end
  # deletes a specific loan
  def delete(id)
    $lender_api_client.delete("/#{@model}/#{id}")
  end

  def sample_data
    n = rand(10...100)
    s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    loan_params = {
        "loan_number": "#{3 * n}#{s[1...5]}#{n}",
        "loan_officer": "",
        "appraisal_type": "Refinance",
        "due_date": Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        "subject_property_address": "100 Mass Ave",
        "subject_property_city": "Boston",
        "subject_property_state": "MA",
        "subject_property_zip": "02192",
        "case_number": "10029MA",
        "loan_type": "FHA"
    }
    loan_params
  end
end
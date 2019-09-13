module Reggora
  class Loan
    def initialize(client)
      @model = 'loan'
      @client = client
    end
    # retrieves all loans, and can take a number of query parameters
    def all(offset = 0, limit = 0, ordering = '-created', loan_officer = [])
      @client.get("/#{@model}s", {offset: offset, limit: limit, ordering: ordering, loan_officer: loan_officer})
    end

    # retrieves a specific loan by id
    def find(id)
      @client.get("/#{@model}/#{id}")
    end

    # creates a loan and returns the ID of the created loan
    def create(loan_params)
      @client.post("/#{@model}", loan_params)
    end

    # edits a loan and returns the ID of the edited loan. Only the provided fields will be updated
    def edit(id, loan_params)
      @client.put("/#{@model}/#{id}", loan_params)
    end
    # deletes a specific loan
    def delete(id)
      @client.delete("/#{@model}/#{id}")
    end

    def sample_data
      n = rand(10...100)
      s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      {
        "loan_number": "#{3 * n}#{s[1...5]}#{n}",
        "loan_officer": "",
        "appraisal_type": "Refinance",
        "due_date": (Time.now + 60*60*24*30).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "subject_property_address": "100 Mass Ave",
        "subject_property_city": "Boston",
        "subject_property_state": "MA",
        "subject_property_zip": "02192",
        "case_number": "10029MA",
        "loan_type": "FHA"
      }
    end
  end
end
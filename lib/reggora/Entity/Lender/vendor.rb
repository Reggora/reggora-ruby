class Vendor
  def initialize
    @model = 'vendor'
  end

  # returns all the vendors associated with the requesting lender.
  def all(offset = 0, limit = 0)
    $lender_api_client.get("/#{@model}s", {offset: offset, limit: limit})
  end

  # takes a vendor ID as a URL parameter and returns the corresponding vendor.
  def find(vendor_id)
    $lender_api_client.get("/#{@model}/#{vendor_id}")
  end

  # returns the vendors associated with the requesting lender filtered by zip code.
  def find_by_zone(zones, offset = 0, limit = 0)
    $lender_api_client.post("/#{@model}s/by_zone", {zones: zones}, {offset: offset, limit: limit})
  end

  # returns the vendors associated with the requesting lender filtered by branch.
  def find_by_branch(branch_id)
    $lender_api_client.get("/#{@model}s/branch", {branch_id: branch_id})
  end

  # adds a vendor to your lender.
  def invite(firm_name, firstname, lastname, email, phone)
    invite_params = vendor_params(firm_name, firstname, lastname, email, phone)
    $lender_api_client.post("/#{@model}", {}, invite_params)
  end

  # edits a vendor. Only the fields that are in the request body will be updated.
  def edit(vendor_id, edit_vendor_params)
    $lender_api_client.put("/#{@model}/#{vendor_id}", edit_vendor_params)
  end

  # removes a vendor from your lender panel.
  def delete(vendor_id)
    $lender_api_client.delete("/#{@model}/#{vendor_id}")
  end

  def vendor_params(firm_name = "", firstname = "", lastname = "", phone = "")
    {
        firm_name: firm_name,
        firstname: firstname,
        lastname: lastname,
        phone: phone
    }
  end
end
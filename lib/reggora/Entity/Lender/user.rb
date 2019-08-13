class User
  def initialize(client)
    @model = 'user'
    @client = client
  end

  # returns a list of all the users in the requesting lender.
  def all(params = {})
    @client.get("/#{@model}s", params)
  end

  # takes a user ID as a URL parameter and returns a user object.
  def find(user_id)
    @client.get("/#{@model}s/#{user_id}")
  end

  # invites a user to the reggora platform
  def invite(email, role, firstname, lastname, phone_number)
    invite_params = invite_params(email, role, firstname, lastname, phone_number)
    @client.post("/#{@model}s/invite", invite_params)
  end

  # creates a user to the reggora platform.
  def create(user_params)
    @client.post("/#{@model}s", user_params)
  end

  # updates a user's information.
  # No fields are required and only the supplied fields will be updated on the user.
  def edit(user_id, user_params)
    @client.put("/#{@model}s/#{user_id}", user_params)
  end

  def delete(user_id)
    @client.delete("/#{@model}s/#{user_id}")
  end

  def user_attributes(email, role, firstname, lastname, phone_number, branch_id = '', nmls_id = '', matched_users = [])
    {
        email: email,
        role: role,
        firstname: firstname,
        lastname: lastname,
        phone_number: phone_number,
        branch_id: branch_id,
        nmls_id: nmls_id,
        matched_users: matched_users
    }
  end

  def invite_params(email, role, firstname, lastname, phone_number)
    {
        email: email,
        role: role,
        firstname: firstname,
        lastname: lastname,
        phone_number: phone_number
    }
  end

  def query_params(ordering = '-created', offset = 0, limit = 0, search = '')
    {
        ordering: ordering,
        offset: offset,
        limit: limit,
        search: search
    }
  end

  def sample_data
    s = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    {
        email: "fake#{s[1...4]}@reggora.com",
        role: "Admin",
        firstname: "Fake",
        lastname: "Person#{s[1...4]}",
        phone_number: "#{rand(100000...99999)}",
        branch_id: '',
        nmls_id: '',
        matched_users: []
    }
  end
end
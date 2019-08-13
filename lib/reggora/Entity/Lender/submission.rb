class Submission
  def initialize(client)
    @model = 'submission'
    @client = client
  end
  # retrieves all submissions associated with an order.
  def all(order_id)
    @client.get("/order-submissions/#{order_id}")
  end

  # retrieves one of the three forms that are associated with an order submission.
  def download_submission_doc(order_id, version, report_type)
    @client.get("/order-submission/#{order_id}/#{version}/#{report_type}")
  end
end

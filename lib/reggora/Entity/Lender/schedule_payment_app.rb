class SchedulePaymentApp

  def send_payment_app(consumer_email, order_id, user_type, payment_type, amount, firstname = '', lastname = '')
    payment_params = payment_attributes(consumer_email, order_id, user_type, payment_type, amount, firstname, lastname)
    $lender_api_client.post('/consumer/payment', payment_params)
  end

  def send_scheduling_app(consumer_emails, order_id)
    $lender_api_client.post("/consumer/scheduling", {consumer_emails: consumer_emails, order_id: order_id})
  end

  # @param [String] order_id
  # @param [String] link_type : payment/schedule/both
  # @param [String] consumer_id
  def consumer_app_link(order_id, consumer_id, link_type)
    $lender_api_client.get("/#{order_id}/#{consumer_id}/#{link_type}")
  end

  def payment_attributes(consumer_email, order_id, user_type, payment_type, amount, firstname = '', lastname = '')

    attributes = {
        consumer_email: consumer_email,
        order_id: order_id,
        user_type: user_type,
        payment_type: payment_type,
        amount: amount
    }

    attributes.merge!({firstname: firstname, lastname: lastname, paid: false}) if user_type == 'manual'
    attributes
  end
end
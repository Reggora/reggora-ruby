class Loan < LenderApiClient
  def all
    loans = LenderApiClient.get('/loans')
    print "\n~~~~~~~ Loans ~~~~~~~\n"
    print loans
  end
end
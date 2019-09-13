require "bundler/setup"
require "reggora"
require "pry"
$user_name = 'max@reggora.com'
$password = 'test123'
$int_token = 'test-api-key'

$lender_api_client = Reggora::LenderApiClient.new($user_name, $password, $int_token)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "bundler/setup"
require "reggora"
require 'dotenv/load'
require 'pry'

$user_name = ENV['USER_NAME']
$password = ENV['USER_PASSWORD']
$int_token = ENV['INT_TOKEN']

if $user_name == nil && $password == nil && $int_token == nil
  raise "Please provide creditials on the .ENV file."
end 


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

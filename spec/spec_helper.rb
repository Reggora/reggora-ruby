require "bundler/setup"
require "reggora"

$user_name = 'jake@reggora.com'
$password = 'reggora123'
$int_token = '906414c6-29f3-4c96-8deb-bbc2f4616275'

Reggora::Lender.new($user_name, $password, $int_token)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

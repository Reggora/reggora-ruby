
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reggora/version'

Gem::Specification.new do |spec|
  spec.name          = 'reggora'
  spec.version       = Reggora::VERSION
  spec.authors       = ['reggora']
  spec.email         = ['development@reggora.com']

  spec.summary       = 'Ruby Client for Reggora Lender/Vendor API'
  spec.description   = 'https://sandbox.reggora.io/'
  spec.homepage      = 'https://rubygems.org/gems/reggora'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/gems/'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/Reggora/reggora-ruby'
    spec.metadata['changelog_uri'] = 'https://github.com/Reggora/reggora-ruby/blob/master/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = [
      "lib/reggora.rb",
      "lib/reggora/Adapters/api_client.rb",
      "lib/reggora/Adapters/requests.rb",
      "lib/reggora/Entity/Lender/loan.rb",
      "lib/reggora/Entity/Lender/order.rb",
      "lib/reggora/Entity/Lender/evault.rb",
      "lib/reggora/Entity/Lender/product.rb",
      "lib/reggora/Entity/Lender/submission.rb",
      "lib/reggora/Entity/Lender/user.rb",
      "lib/reggora/Entity/Lender/vendor.rb",
      "lib/reggora/Entity/Lender/schedule_payment_app.rb",
  ]
  # spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/})}
  # end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'mime-types', '~> 3.1'
end

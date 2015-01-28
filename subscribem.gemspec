$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "subscribem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "subscribem"
  s.version     = Subscribem::VERSION
  s.authors     = ["Cynthia Kiser"]
  s.email       = ["cnk@caltech.edu"]
  s.homepage    = "https://leanpub.com/multi-tenancy-rails"
  s.summary     = "Example app from Multitenancy with Rails"
  s.description = "Example app from Multitenancy with Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "bcrypt", "~> 3.1.7"
  s.add_dependency "warden"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end

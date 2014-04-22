# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_sagepay_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "spree_sagepay_server"
  s.version     = SpreeSagepayServer::VERSION
  s.summary     = "SagePay Server ingration for Spree"
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.2'

  s.authors     = ["Made", "Seb Ashton"]
  s.email       = ["seb@madetech.co.uk"]
  s.homepage    = "https://www.madetech.co.uk"
  s.license      = %q{BSD-3}


  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'spree_core', '~> 2.0.3'
  s.add_dependency 'sage_pay', '1.0.0'

  s.add_development_dependency 'cane'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'require_all'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tailor'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'yarjuf'
end

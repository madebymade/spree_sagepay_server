# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_sagepay_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "spree_sagepay_server"
  s.version     = SpreeSagepayServer::VERSION
  s.summary     = "SagePay Server integration for Spree"
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.2'

  s.authors     = ["Made", "Seb Ashton", "Chris Blackburn"]
  s.email       = ["seb@madetech.co.uk", "chris@madetech.co.uk"]
  s.homepage    = "https://www.madetech.co.uk"
  s.license      = %q{BSD-3}


  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'spree_core', '~> 2.4.0'
  s.add_dependency 'sage_pay', '1.0.0'
end

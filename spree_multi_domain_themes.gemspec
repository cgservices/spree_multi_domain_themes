$:.push File.expand_path("../lib", __FILE__)

require 'spree_multi_domain_themes/version'

# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multi_domain_themes'
  s.version     = SpreeMultiDomainThemes::VERSION
  s.summary     = 'Spree extension to allow separate views per store.'
  s.description = 'Spree extension to allow separate views per store.'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'L. Doubrava'
  s.email     = 'luis@cg.nl'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core'
  s.add_dependency 'spree_multi_domain'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
end

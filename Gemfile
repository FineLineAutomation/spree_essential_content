source 'https://rubygems.org'

gem 'spree', github: 'spree/spree', branch: '3-0-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'

if ENV['SAUCY']
  # gems for sauce
  gem 'sauce'
  gem 'sauce-connect'
  gem 'parallel_tests'
  gem 'selenium-webdriver'
end

gemspec

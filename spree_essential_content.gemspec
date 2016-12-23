# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_essential_content'
  s.version     = '3.0.0'
  s.authors     = ["Spencer Steffen", "Nathan Lowrie"]
  s.email       = ["spencer@citrusme.com", "nate@finelineautomation.com"]
  s.homepage    = "https://github.com/FineLineAutomation/spree_essential_content"
  s.summary     = %q{Spree Essentials provides a CMS for Spree Commerce sites. See readme for details...}
  s.description = %q{Spree Essentials provides a CMS for Spree Commerce sites. It provides static pages, content snippets, blogs, and an asset-upload interface.}
  s.required_ruby_version = '>= 2.0.0'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.1.3'
  s.add_dependency 'warden', '~> 1.2.5'
  s.add_runtime_dependency('acts-as-taggable-on')

  s.add_development_dependency 'capybara', '~> 2.7'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.7'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.4'
  s.add_development_dependency 'sass-rails', '~> 5.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry-rails'
end

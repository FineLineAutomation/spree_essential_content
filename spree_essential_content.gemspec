# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_essential_content'
  s.version     = '2.3.0'
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

  s.add_dependency 'spree_core', '~> 2.3.0'
  s.add_dependency 'listen', '~> 2.8.0'
  s.add_runtime_dependency('acts-as-taggable-on')

  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'capybara', '~> 2.2.1'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'database_cleaner', '1.2.0'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'sqlite3', '~> 1.3.8'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'poltergeist', '~> 1.5.0'
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
end

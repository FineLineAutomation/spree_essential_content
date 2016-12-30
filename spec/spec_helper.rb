require 'simplecov'
SimpleCov.start do
  add_filter 'spec/dummy'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib'
end

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'ffaker'
require 'rspec/rails'
require 'database_cleaner'
require 'capybara/rspec'
require 'capybara/rails'
require 'paperclip/matchers'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/preferences'
require 'spree/testing_support/flash'
require 'selenium-webdriver'

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.use_transactional_fixtures = false

  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::TestingSupport::UrlHelpers
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::Flash
  config.include Paperclip::Shoulda::Matchers
  config.include Devise::TestHelpers, type: :controller

  config.extend Spree::TestingSupport::AuthorizationHelpers::Request, type: :feature

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do |example|
    DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start

    if ENV['SAUCY']
      caps = Selenium::WebDriver::Remote::Capabilities.firefox({
        'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER']
      })
      driver = Selenium::WebDriver.for(:remote, {
        url: "http://localhost:4445",
        desired_capabilities: caps
      })
    end
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.fail_fast = ENV['FAIL_FAST'] || false

  config.after(:each) do
    if !@driver.nil? and NV['SAUCY']
      @driver.quit
    end
  end
end

module Spree
  module TestingSupport
    module CapybaraHelpers
      def sign_in_as!(user)
        visit spree.login_path
        within '#new_spree_user' do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
        end
        click_button 'Login'
      end
    end
  end
end
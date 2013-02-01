# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

require 'database_cleaner'

require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/controller_requests'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/testing_support/preferences'
require 'spree/core/testing_support/flash'

require 'spree/core/url_helpers'
require 'capybara/rspec'
require 'capybara/rails'
require 'paperclip/matchers'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation, { :except => ['spree_countries', 'spree_zones', 'spree_zone_members', 'spree_states', 'spree_roles'] }
    else
      DatabaseCleaner.strategy = :transaction
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
    reset_spree_preferences
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Spree::Core::UrlHelpers
  config.include Spree::Core::TestingSupport::ControllerRequests
  config.include Spree::Core::TestingSupport::Preferences
  config.include Spree::Core::TestingSupport::Flash

  config.include Paperclip::Shoulda::Matchers
end

def fill_in_js(selector, value)
  page.execute_script %Q{$('#{selector}').val('#{value}').keydown()}
end


def spree
  Spree::Core::Engine.routes.url_helpers
end

def request
  @request
end

# Stub authorization for all admin controllers
def stub_authorization!
  subclasses = Spree::Admin::BaseController.subclasses + Spree::Admin::ResourceController.subclasses
  subclasses.each do |klass|
    klass.any_instance.stub(:authorize!).and_return(true)
  end
end

# An assertion for ensuring content has made it to the page.
#
#    assert_seen "Site Title"
#    assert_seen "Peanut Butter Jelly Time", :within => ".post-title h1"
#
def assert_seen(text, opts={})
  msg = "Should see `#{text}`"
  if opts[:within]
    within(opts[:within]) do
      expect(has_content?(text)).to eq(true)
    end
  else
    expect(has_content?(text)).to eq(true)
  end
end

# Asserts the proper flash message
#
#    assert_flash :notice, "Post was successfully saved!"
#    assert_flash :error, "Oh No, bad things happened!"
#
def assert_flash(key, text)
  within(".flash.#{key}") do
    assert_seen(text)
  end
end

# Asserts the proper browser title
#
#    assert_title "My Site - Is super cool"
#
def assert_title(title)
  assert_seen title, :within => "head title"
end

# Asserts meta tags have proper content
#
#    assert_meta :description, "So let me tell you about this one time..."
#    assert_meta :keywords, "seo, is, fun, jk."
#
def assert_meta(tag, text)
  tag = find(:xpath, "//head/meta[@name='#{tag.to_s}']")
  expect(text).to eq(tag.native.attribute("content"))
end

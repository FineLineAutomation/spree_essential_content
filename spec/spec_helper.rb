# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories defined in spree_core
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/controller_requests'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/url_helpers'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::Core::UrlHelpers

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
  config.use_transactional_fixtures = true
end

def spree
  Spree::Core::Engine.routes.url_helpers
end  
  
def request
  @request
end

# not sure why setting the request_uri doesn't also update @fullpath
def visit(path="/")
  @request.request_uri = path
  @request.instance_variable_set "@fullpath", path 
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
      expect(has_content?(text)).to eq(msg + " within #{opts[:within]}")
    end
  else
    expect(has_content?(text)).to eq(msg)
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

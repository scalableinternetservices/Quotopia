ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module FixtureFileHelpers
  def string_md5(string)
    Digest::MD5.hexdigest(string.downcase)
  end
end
ActiveRecord::FixtureSet.context_class.send :include, FixtureFileHelpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'
require 'byebug'

DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }

Capybara.app = TrafficSpy::Server

class ControllersTest < Minitest::Test
  include Rack::Test::Methods

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start #move these two methods to test helper
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTest < ControllersTest
  include Capybara::DSL

  def setup
    super
    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post "/sources/jumpstartlab/data", 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end
end

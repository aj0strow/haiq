require_relative '../app'
require 'rack/test'
require 'database_cleaner'
require 'fabrication'

OmniAuth.config.test_mode = true
DatabaseCleaner.strategy = :truncation

module Helpers
  def app
    Sinatra::Application
  end

  def json
    MultiJson.load(last_response.body)
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Helpers
  config.after :all do
    DatabaseCleaner.clean
  end
end

Fabricator(:user) do
  twitter_id { sequence(:twitter_id).to_s }
  name 'Twitter User'
  image 'http://profile.image.jpg'
end

Fabricator(:haiku) do
  user { Fabricate(:user) }
  first 'this is a test class'
  second 'for the haiku ruby class'
  third 'and should be valid'  
end

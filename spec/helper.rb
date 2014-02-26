require_relative '../app'
require 'rack/test'

module Helpers
  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Helpers
end
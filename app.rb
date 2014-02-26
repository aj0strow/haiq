require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/assetpack'
require 'sinatra/mustache'
require 'sequel'

set :logging, false
set :root, File.dirname(__FILE__)
set :views, -> { root + '/app/templates' }
set :postgres, -> { ENV.fetch('DATABASE_URL', "postgres://localhost/hiq_#{environment}") }
set :db, -> { Sequel.connect(postgres) }

register Sinatra::AssetPack

get '/' do
  mustache :index
end

assets do
  serve '/scripts', from: 'app/scripts'
  serve '/components', from: 'app/components'

  js :application, '/assets/application.js', [
    '/components/requirejs/require.js',
    '/scripts/boot.js'
  ]
end

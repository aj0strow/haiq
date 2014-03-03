require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/mustache'
register Sinatra::MustacheHelper

require 'require_all'
require_all 'app/helpers'
register Database, Assets, Auth, Routes
require_all 'app/models'

set :logging, false
set :root, File.dirname(__FILE__)
set :views, -> { root + '/app/views' }

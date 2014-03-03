require 'json'
require 'multi_json'

module Routes
  module Helpers
    def json(model)
      content_type :json
      model = model.as_json if model.respond_to?(:as_json)
      MultiJson.dump(model)
    end

    def persist(model)
      if model.valid?
        model.save
        status 200
        json model
      else
        status 422
        json model.errors.full_messages
      end
    end

    def haiku_params
      params.symbolize_keys.slice(:first, :second, :third)
    end
  end

  def self.registered(base)
    base.helpers Helpers

    base.get '/' do
      erb :index, current_user: current_user
    end

    base.get '/recent' do
      erb :recent
    end

    base.get '/me' do
      erb :me
    end

    base.post '/haikus', provides: :json do
      authenticate!
      haiku = Haiku.new(haiku_params.merge(user: current_user))
      persist haiku
    end

    base.get '/haikus/paginate/?:id?', provides: :json do
      haikus = Haiku.reverse_order(:id).limit(12)
      haikus = haikus.where('id < ?', params[:id]) if params[:id]
      json haikus
    end

    base.get '/word', provides: :json do
      word = Word.new(params[:w])
      begin
        json word: word, syllables: word.syllables 
      rescue ArgumentError => ex
        status 404
        json error: ex.message 
      end
    end
  end
end

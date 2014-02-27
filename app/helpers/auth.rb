require 'omniauth-twitter'

module Auth
  module Helpers
    def auth_hash
      request.env['omniauth.auth']
    end

    def current_user
      @current_user ||= User.find(id: session[:user_id])
    end

    def sign_in(user)
      session[:user_id] = user.id
      @current_user = user
    end

    def sign_out
      session[:user_id] = @current_user = nil
    end
  end

  def self.registered(base)
    base.helpers Helpers

    base.use Rack::Session::Cookie, secret: ENV['SECRET']

    base.use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    end

    base.get '/auth/twitter/callback' do
      user = User.find_or_create(twitter_id: auth_hash.uid) do |user|
        info = auth_hash.info
        user.set(name: info.name, image: info.image)
      end
      sign_in user
      redirect '/'
    end

    base.get '/logout' do
      sign_out
      redirect '/'
    end
  end
end

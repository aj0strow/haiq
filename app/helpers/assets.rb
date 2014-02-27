require 'sinatra/assetpack'

module Assets
  def self.registered(app)
    app.register Sinatra::AssetPack

    app.assets do
      serve '/scripts', from: 'app/scripts'
      serve '/components', from: 'app/components'

      js :application, '/assets/application.js', [
        '/components/requirejs/require.js',
        '/scripts/boot.js'
      ]
    end
  end
end

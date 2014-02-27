require 'sinatra/assetpack'

module Assets
  def self.registered(app)
    app.register Sinatra::AssetPack

    app.assets do
      serve '/images', from: 'app/images'
      serve '/scripts', from: 'app/scripts'
      serve '/styles', from: 'app/styles'
      serve '/components', from: 'app/components'

      css :global, '/assets/global.css', [
        '/styles/global.css'
      ]

      js :application, '/assets/application.js', [
        '/components/es5-shim/es5-shim.js',
        '/components/es5-shim/es5-sham.js',
        '/components/jquery/dist/jquery.js',
        '/components/flight-standalone/flight.js',
        '/scripts/namespace.js',
        '/scripts/menu.js',
        '/scripts/boot.js'
      ]
    end
  end
end

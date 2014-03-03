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
        '/components/angular/angular.js',
        '/components/angular-route/angular-route.js',
        '/scripts/app.js',
        '/scripts/syllables.js'
      ]
    end
  end
end

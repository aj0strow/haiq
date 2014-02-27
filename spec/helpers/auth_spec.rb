describe Auth do
  describe 'GET /auth/twitter/callback' do
    before do
      auth_hash = {
        uid: '12345',
        info: { name: 'AJ', image: 'img-url' }
      }
      OmniAuth.config.add_mock(:twitter, auth_hash)
      get '/auth/twitter'
      follow_redirect!
    end

    it 'should redirect to home page' do
      expect(last_request.path).to eq('/auth/twitter/callback')
      follow_redirect!
      expect(last_request.path).to eq('/')
    end

    it 'should create new user' do
      expect(User.find(twitter_id: '12345').name).to eq('AJ')
    end
  end

  describe 'GET /logout' do
    before { get '/logout' }

    it 'should redirect to home page' do
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end

describe Routes do
  describe 'GET /' do
    before { get '/' }

    it 'should come thru' do
      expect(last_response).to be_successful
    end
  end

  describe 'POST /haikus' do
    let(:user) { Fabricate(:user) }

    specify 'auth required' do
      post '/haikus'
      expect(last_response.status).to eq(401)
    end

    specify 'create haiku' do
      attrs = { first: 'hi hi hi hi hi', second: 'hi hi hi hi hi hi hi', third: 'hi hi hi hi hi' }
      post('/haikus', attrs, 'rack.session' => { user_id: user.id })
      expect(last_response).to be_successful
      expect(Haiku.last.user).to eq(user)
    end
  end

  describe 'GET /haikus/paginate' do
    specify 'defaults to most recent' do
      haiku = Fabricate(:haiku)
      get '/haikus/paginate'
      expect(json[0]['id']).to eq(haiku.id)
    end

    specify 'returns the next few' do
      haiku = Fabricate(:haiku)
      get "/haikus/paginate/#{haiku.id}"
      expect(json[0]['id']).not_to eq(haiku.id)
    end
  end

  describe 'GET /word' do
    specify 'returns syllables' do
      get '/word', w: 'hello'
      expect(json).to eq('word' => 'hello', 'syllables' => 2)
    end

    specify 'returns 404 for not found' do
      get '/word', w: 'yee'
      expect(last_response.status).to eq(404)
    end
  end
end

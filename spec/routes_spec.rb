describe Sinatra::Application do
  describe 'GET /' do
    before { get '/' }

    it 'should come thru' do
      expect(last_response).to be_successful
    end
  end

  describe 'GET /assets/appliction.js' do
    before { get '/assets/application.js' }
    subject { last_response }
    it { should be_successful }
  end
end

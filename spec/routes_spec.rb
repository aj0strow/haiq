describe Sinatra::Application do
  describe 'GET /' do
    before { get '/' }

    it 'should come thru' do
      expect(last_response).to be_successful
    end
  end
end

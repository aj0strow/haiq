describe Assets do
  describe 'GET /assets/appliction.js' do
    before { get '/assets/application.js' }
    subject { last_response }
    it { should be_successful }
  end

  describe 'GET /assets/global.css' do
    before { get '/assets/global.css' }
    subject { last_response }
    it { should be_successful }
  end
end

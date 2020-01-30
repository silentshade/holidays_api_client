RSpec.describe HolidaysApiClient::Authenticator do
  let(:token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.' }

  before { stub_request(:post, HolidaysApiClient::Configuration.authenticate_url).to_return(status: 200, body: response, headers: {}) }

  subject { described_class.call }

  describe 'valid' do
    let(:response) { { "token": token }.to_json }

    it { is_expected.to eq(token) }
  end

  describe 'invalid response' do
    let(:response) { nil }

    it { expect { subject }.to raise_error(HolidaysApiClient::Error, 'Token not valid') }
  end
end

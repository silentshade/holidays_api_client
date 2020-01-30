RSpec.describe HolidaysApiClient::Fetcher do
  let(:response) { YAML.load_file('spec/support/data.yaml') }
  subject(:result) { described_class.call(token: 'foobar', params: { from: '2019-12-31', to: '2020-01-01', country_code: 'jp' }) }

  before(:each) do
    stub_request(:get, "#{HolidaysApiClient::Configuration.holidays_url}?country_code=jp&from=2019-12-31&to=2020-01-01")
      .with(headers: { 'Authorization' => 'foobar' }).to_return(status: 200, body: response, headers: {})
  end

  context 'ja' do
    before { I18n.locale = :ja }
    it { is_expected.to eq("2020-01-01" => "元日", "2019-12-31" => "大晦日") }
  end

  context 'en' do
    before { I18n.locale = :en }
    it { is_expected.to eq("2020-01-01" => "New Year", "2019-12-31" => "New Year's Eve") }
  end

  describe 'invalid response' do
    let(:response) { nil }
    it { expect { result }.to raise_error(HolidaysApiClient::Error) }
  end
end

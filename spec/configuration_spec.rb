RSpec.describe HolidaysApiClient::Configuration do
  describe '.confgure' do

    context 'when valid params passed' do
      let(:blk) do
        lambda do |config|
          config.api_url = 'http://test.com'
          config.email = 'example@example.com'
          config.password = 'pass'
          config.auth_path = '/auth'
          config.index_path = '/holidays'
        end
      end

      it 'saves passed values' do
        described_class.configure(&blk)
        expect(described_class.email).to eq 'example@example.com'
        expect(described_class.password).to eq 'pass'
        expect(described_class.authenticate_url).to eq 'http://test.com/auth'
        expect(described_class.holidays_url).to eq 'http://test.com/holidays'
      end
    end

    context 'when invalid param is passed' do
      let(:blk) do
        lambda do |config|
          config.some_param = '12345'
        end
      end

      it "doesn't save this value" do
        expect(described_class.respond_to?(:some_param)).to be_falsey
      end
    end
  end
end

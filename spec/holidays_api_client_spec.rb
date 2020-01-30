RSpec.describe HolidaysApiClient do
  it 'has a version number' do
    expect(HolidaysApiClient::VERSION).not_to be nil
  end

  let(:blk) { lambda { |config| config.api_url = 'http://test.url' } }
  
  it 'sends configure block to Configuration class' do
    expect(HolidaysApiClient::Configuration).to receive(:configure) do |*_, &block|
      expect(block).to be(blk)
    end
    described_class.configure(&blk)
  end
end

require 'spec_helper'

describe DarkSky::Configuration do
  describe 'configure' do
    it 'should have default configuration' do
      DarkSky.configure do |configuration|
        expect(configuration.api_endpoint).to eq(DarkSky::Configuration::API_ENDPOINT)
        expect(configuration.api_key).to be_nil
        expect(configuration.timeout).to be_nil
      end
    end
  end
end

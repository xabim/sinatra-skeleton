require 'spec_helper'

describe DarkSky do
    let(:product_json) { File.read('spec/fixtures/forecast.json') }

  before do
    DarkSky.configure do |c|
      c.api_key = 'api_key'
    end
  end

  describe 'request_forecast' do
    it 'should return forecast for a given latitude, longitude' do
      stub_request(:get, "https://api.darksky.net/forecast/api_key/39.4697,-0.37739").to_return(status: 200, body: product_json, headers: {})

      forecast = DarkSky.request_forecast('39.4697','-0.37739')

      expect(forecast).to_not be_nil
      expect(forecast["latitude"]).to eq(39.4697)
      expect(forecast["longitude"]).to eq(-0.37739)
      expect(forecast["currently"]).to_not be_nil
      expect(forecast["daily"].size).to eq(3)
    end
  end

  describe 'request_forecast' do
    it 'should return forecast for a given latitude, longitude and time' do
      stub_request(:get, "https://api.darksky.net/forecast/api_key/39.4697,-0.37739,1577786400").to_return(status: 200, body: product_json, headers: {})
      forecast = DarkSky.request_forecast('39.4697','-0.37739', time: Time.utc(2019, 12, 31, 10).to_i)

      expect(forecast).to_not be_nil
      expect(forecast["latitude"]).to eq(39.4697)
      expect(forecast["longitude"]).to eq(-0.37739)
      expect(forecast["currently"]).to_not be_nil
    end
  end

  describe 'request_forecast' do
    let(:product_json) { File.read('spec/fixtures/forecast_si.json') }

    it 'should return forecast for a given latitude, longitude and parameters' do
      stub_request(:get, "https://api.darksky.net/forecast/api_key/39.4697,-0.37739?units=si").to_return(status: 200, body: product_json, headers: {})
      forecast = DarkSky.request_forecast('39.4697','-0.37739', {:parameters => { :units => ["si"] }})

      expect(forecast).to_not be_nil
      expect(forecast["latitude"]).to eq(39.4697)
      expect(forecast["longitude"]).to eq(-0.37739)
      expect(forecast["currently"]).to_not be_nil
      expect(forecast["currently"]).to_not be_nil
      expect(forecast["flags"]["units"]).to eq("si")
    end
  end
end

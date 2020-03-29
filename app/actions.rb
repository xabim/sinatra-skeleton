# Homepage (Root path)
get '/' do
  erb :index
end

require_relative '../lib/darksky'
require 'opencage/geocoder'
require 'dotenv'

get '/:address' do
  Dotenv.load
  geocoder = OpenCage::Geocoder.new(api_key: ENV['GEOCODER_API_KEY'])

  results = geocoder.geocode(params['address'])
  if results.empty?
    @address = params['address']
    erb :not_found
  else
    coordinates = results.first.coordinates
    country_code = results.first.components["ISO_3166-1_alpha-2"]

    @units = "ºC"

    # The last imperial countries in the world
    imperial_countries = ["LR", "MM", "US"]
    country_units = "si"
    if imperial_countries.index(country_code) != nil
      country_units = "us"
      @units = "ºF"
    end

    # Get forecast
    DarkSky.configure do |c|
      c.api_key = ENV['DARKSKY_API_KEY']
    end

    forecast = DarkSky.request_forecast(coordinates[0],coordinates[1],{:parameters => { :units => [country_units] }})

    @temperature = forecast["currently"]["temperature"].round
    @city = results.first.components["city"]
    @state = results.first.components["state"]
    @country = results.first.components["country"]

    erb :temperature
  end
end

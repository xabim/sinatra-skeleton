require_relative 'darksky/configuration'

require 'net/https'
require 'json'

module DarkSky
  extend Configuration

  class << self
    # Retrieve the forecast for a given latitude and longitude.
    #
    # @param latitude [String] Latitude.
    # @param longitude [String] Longitude.
    # @param options [String] Optional parameters. Valid options are `:time` and `:params`
    #
    # Example: DarkSky::request_forecast(1,1,{:parameters => { :lang => ["es"] }})
    def request_forecast(latitude, longitude, options = {})
      request_url = "https://#{DarkSky.api_endpoint}/forecast/#{DarkSky.api_key}/#{latitude},#{longitude}"
      request_url << ",#{options[:time]}" if options[:time]

      request_response = request(request_url, options[:parameters])

      request_code = request_response.code.to_i
      request_code < 400 ? parse_response(request_response.body) : "Error: #{request_code}"
    end

    private

    def request(url, params = {})
      uri = URI("#{url}")
      uri.query = URI.encode_www_form(params) unless params.nil?

      response = connection.request(Net::HTTP::Get.new("#{uri}"))
    end

    def connection
      http = Net::HTTP.new("#{DarkSky.api_endpoint}", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http
    end

    def parse_response(response)
      JSON.parse(response)
    end
  end
end
module DarkSky
  module Configuration
    API_ENDPOINT = 'api.darksky.net'

    attr_accessor :api_endpoint
    attr_accessor :api_key
    attr_accessor :timeout

    #   DarkSky.configure do |c|
    #     c.api_endpoint = 'https://api.darksky.net'
    #     c.api_key = 'api_key'
    #     c.timeout = 500
    #   end
    def configure
      yield self
    end

    def api_endpoint
      @api_endpoint ||= API_ENDPOINT
    end
  end
end

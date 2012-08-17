module Appfigures
  class Connection < Faraday::Connection
    def initialize(username, password)
      super('https://api.appfigures.com/v1.1/') do |builder|
        builder.use       FaradayMiddleware::EncodeJson
        builder.adapter   Faraday.default_adapter
        builder.response  :json, :content_type => /\bjson$/
      end

      self.basic_auth username, password
      self.headers["Accept"] = 'application/json'
    end
  end
end

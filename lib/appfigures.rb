require 'faraday'
require 'faraday_middleware'
require 'multi_json'
require 'hashie'

require 'appfigures/version'
require 'appfigures/connection'
require 'appfigures/sales'

module Appfigures
  class << self
    def connection(options = {})
      return @connection unless options[:user] && options[:password]
      @connection = Appfigures::Connection.new(options[:user], options[:password])
    end

    def sales
      Appfigures::Sales.new
    end
  end
end

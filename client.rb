require 'yaml'
require 'httparty'
require 'json'
require_relative 'query'
require_relative 'request'

module Rbdash
  class Client
    def initialize
    end

    def queries
      response = Query.find_all
      results = JSON.parse(response.body)['results']
      results.each do |result|
        q = Query.parse_response(result)
        q.save
      end
    end

    def update_query(id)
      response = Query.update(id)
      puts response if response
    end
  end
end

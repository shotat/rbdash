require 'yaml'
require 'httparty'
require 'json'
require_relative 'query'

module Redash
  class Client
    include HTTParty

    def initialize(uri, token)
      self.class.base_uri(uri)
      @uri = uri
      @options = {
        verify: false,
        headers: {'Authorization': token }
      }
    end

    def queries
      response = self.class.get('/api/queries', @options)
      if response.code != 200
        puts "something went wrong."
        return
      end
      results = JSON.parse(response.body)['results']
      results.each do |result|
        q = Query.parse_response(result)
        q.save
      end
    end

    def update_query(id)
      response = self.class.get('/api/queries', @options)
      JSON.parse(response.body)
    end
  end
end

config = YAML.load_file('./config.yml')
base_uri = config['base_uri']
token = config['token']
client = Redash::Client.new(base_uri, token)
client.queries

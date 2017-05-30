require 'yaml'
require 'httparty'
require 'json'
require_relative 'query'

module Rbdash
  class Request
    include HTTParty

    def initialize
      config = YAML.load_file('./config.yml')
      self.class.base_uri(config['base_uri'])
      @default_options = {
        verify: false,
        headers: { 'Authorization' => config['token'] }
      }
    end

    def get(ep, params = {}, options = {})
      self.class.get(ep, @default_options.merge(options.merge(query: params)))
    end

    def post(ep, body = {}, options = {})
      self.class.post(ep, @default_options.merge(options.merge(query: body)))
    end
  end
end

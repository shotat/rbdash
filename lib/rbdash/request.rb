require 'yaml'
require 'httparty'
require 'json'

module Rbdash
  class Request
    include HTTParty
    # debug_output $stdout

    def initialize
      config = YAML.load_file('./config.yml')
      self.class.base_uri(config['base_uri'])
      @default_options = {
        verify: false,
        headers: {
          'Authorization' => config['token'],
          'Content-Type' => 'application/json'
        }
      }
    end

    def get(ep, params: {}, options: {})
      self.class.get(ep, @default_options.merge(options.merge(query: params)))
    end

    def post(ep, body: {}, options: {})
      self.class.post(ep, @default_options.merge(options.merge(body: body.to_json)))
    end
  end
end

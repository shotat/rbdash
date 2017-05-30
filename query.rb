require_relative 'request'

module Redash
  class Query
    DIRNAME = 'queries'.freeze

    attr_accessor :id,             # number
                  :data_source_id, # number
                  :query,          # string
                  :name,           # string
                  :description,    # string
                  :schedule,       # string
                  :options         # object
    def initialize
      # do something
    end

    def self.find_all
      response = Redash::Request.new.get('/api/queries')
      if response.code != 200
        puts "something went wrong."
        return
      end
      response
    end

    def self.update(id)
      request_body = self.load(id).to_h
      response = Redash::Request.new.post("/api/queries/#{id}", request_body)
      if response.code != 200
        puts "something went wrong."
        puts response.code
        puts response.headers
        return
      end
      response
    end

    def self.parse_response(result)
      q = new
      q.id = result['id']
      q.data_source_id = result['data_source_id']
      q.schedule = result['schedule']
      q.query = result['query']
      q.description = result['description']
      q.name = result['name']
      q.options = result['options']
      q
    end

    def to_json
      JSON.pretty_generate(to_h)
    end

    def to_h
      {
        'id': id,
        'data_source_id': data_source_id,
        'query': query,
        'name': name,
        'description': description,
        'options': options
      }
    end

    def save
      Dir.mkdir(DIRNAME) unless File.exist?(DIRNAME)
      filename = "#{DIRNAME}/query-#{id}.json"
      File.open(filename, 'w+') do |f|
        f.puts(to_json)
      end
    end

    def self.load(id)
      file = Dir.glob("#{DIRNAME}/query-#{id}.json").first
      raise StandardError, 'id not found' unless file
      parse_response(JSON.parse(File.read(file)))
    end
  end
end

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
      h = {
        id: id,
        data_source_id: data_source_id,
        query: query,
        name: name,
        description: description,
        options: options
      }
      JSON.pretty_generate(h)
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
      JSON.parse(File.read(file))
      # parse_response(json)
    end
  end
end

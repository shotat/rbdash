module Redash
  class Query
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
      dirname = 'queries'
      Dir.mkdir(dirname) unless File.exists?(dirname)
      filename = "#{dirname}/query-#{data_source_id}-#{id}.json"
      File.open(filename, 'w+') do |f|
        f.puts(to_json)
      end
    end
  end
end

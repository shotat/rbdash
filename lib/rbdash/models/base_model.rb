require_relative '../request'

module Rbdash
  module Models
    class BaseModel
      attr_accessor :body

      def initialize(body)
        @body = body
      end

      def to_json
        JSON.pretty_generate(body)
      end

      def save
        id = @body["id"]
        dirname = self.class.dirname
        Dir.mkdir(dirname) unless File.exist?(dirname)
        filename = "#{dirname}/query-#{id}.json"
        File.open(filename, 'w+') do |f|
          f.puts(to_json)
        end
        true
      end

      class << self
        def client
          Rbdash::Request.new
        end

        def find(id)
          response = client.get("#{endpoint}/#{id}")
          if response.code != 200
            puts response.code
            raise StandardError.new('abort!')
          end
          h = JSON.parse(response.body)
          body = h.select { |k, _| attributes.map(&:to_s).include?(k) }
          new(body)
        end

        def find_all
          response = client.get("#{endpoint}")
          if response.code != 200
            puts response.code
            raise StandardError.new('abort!')
          end
          h = JSON.parse(response.body)
          results = h['results']
          results.map do |result|
            body = result.select { |k, _| attributes.map(&:to_s).include?(k) }
            new(body)
          end
        end

        def update(id)
          request_body = self.load(id).body
          response = client.post("#{endpoint}/#{id}", body: request_body)
          if response.code != 200
            puts response.code
            raise StandardError.new('abort!')
          end
          response
        end

        def load(id)
          file = Dir.glob("#{dirname}/query-#{id}.json").first
          raise StandardError, 'id not found' unless file
          body = JSON.parse(File.read(file))
          new(body)
        end
      end
    end
  end
end

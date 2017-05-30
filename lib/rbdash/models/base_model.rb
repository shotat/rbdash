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
        id = @body['id']
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
            raise StandardError, 'abort!'
          end
          h = JSON.parse(response.body)
          body = h.select { |k, _| attributes.map(&:to_s).include?(k) }
          new(body)
        end

        def find_all
          all_results = []
          (1..100).each do |current_page|
            response = client.get(endpoint.to_s, params: { page: current_page })
            if response.code != 200
              puts response.code
              raise StandardError, 'abort!'
            end
            h = JSON.parse(response.body)
            results = h['results']
            all_results += results.map do |result|
              body = result.select { |k, _| attributes.map(&:to_s).include?(k) }
              new(body)
            end

            count = h['count']
            page = h['page']
            page_size = h['page_size']
            break if count <= page * page_size
          end
          all_results
        end

        def update(id)
          request_body = load(id).body
          response = client.post("#{endpoint}/#{id}", body: request_body)
          if response.code != 200
            puts response.code
            raise StandardError, 'abort!'
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

require_relative 'base_model'

module Rbdash
  module Models
    class Query < BaseModel

      def self.attributes
        [
          :id,             # number
          :data_source_id, # number
          :query,          # string
          :name,           # string
          :description,    # string
          :schedule,       # string
          :options         # object
        ]
      end

      def self.endpoint
        '/queries'
      end

      def self.dirname
        'queries'
      end
    end
  end
end

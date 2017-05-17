require 'cta_aggregator_client/api/client'

module CTAAggregatorClient
  module Location 
    class << self

      def list(filters = {})
        API::Client.list(:location, filters)
      end

      def find(uuid)
        API::Client.find(:location, uuid)
      end

      def create(attributes = {})
        attrs = {
          'address': attributes[:address],
          'city': attributes[:city],
          'state': attributes[:state],
          'zipcode': attributes[:zipcode],
          'notes': attributes[:notes]
        }.reject{ |k,v| v.nil? }

        API::Client.create(:location, attrs)
      end

    end
  end
end

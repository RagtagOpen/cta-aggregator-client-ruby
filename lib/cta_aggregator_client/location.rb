require 'cta_aggregator_client/api_client'

module CTAAggregatorClient
  module Location 
    class << self

      def list(filters = {})
        APIClient.list(:location, filters)
      end

      def find(uuid)
        APIClient.find(:location, uuid)
      end

      def create(attributes = {})
        attrs = {
          'address': attributes[:address],
          'city': attributes[:city],
          'state': attributes[:state],
          'zipcode': attributes[:zipcode],
          'notes': attributes[:notes]
        }.reject{ |k,v| v.nil? }

        APIClient.create(:location, attrs)
      end

    end
  end
end

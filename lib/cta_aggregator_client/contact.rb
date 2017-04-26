require 'cta_aggregator_client/api_client'

module CTAAggregatorClient
  module Contact 
    class << self

      def list(filters = {})
        APIClient.list(:contact, filters)
      end

      def find(uuid)
        APIClient.find(:contact, uuid)
      end

      def create(attributes = {})
        attributes = {
          'name': attributes[:name],
          'phone': attributes[:phone],
          'email': attributes[:email],
          'website': attributes[:website],
        }.reject{ |k,v| v.nil? }

        APIClient.create(:contact, attributes)
      end

    end
  end
end

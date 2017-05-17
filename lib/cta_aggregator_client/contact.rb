require 'cta_aggregator_client/api/client'

module CTAAggregatorClient
  module Contact 
    class << self

      def list(filters = {})
        API::Client.list(:contact, filters)
      end

      def find(uuid)
        API::Client.find(:contact, uuid)
      end

      def create(attributes = {})
        attributes = {
          'name': attributes[:name],
          'phone': attributes[:phone],
          'email': attributes[:email],
          'website': attributes[:website],
        }.reject{ |k,v| v.nil? }

        API::Client.create(:contact, attributes)
      end

    end
  end
end

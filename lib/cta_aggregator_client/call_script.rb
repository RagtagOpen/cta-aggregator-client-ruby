require 'cta_aggregator_client/api_client'

module CTAAggregatorClient
  module CallScript 
    class << self

      def list(filters = {})
        APIClient.list(:call_script, filters)
      end

      def find(uuid)
        APIClient.find(:call_script, uuid)
      end

      def create(attributes = {})
        attributes = { 'text': attributes[:text] }

        APIClient.create(:call_script, attributes)
      end

    end
  end
end

require 'cta_aggregator_client/api/client'

module CTAAggregatorClient
  module CallScript 
    class << self

      def list(filters = {})
        API::Client.list(:call_script, filters)
      end

      def find(uuid)
        API::Client.find(:call_script, uuid)
      end

      def create(attributes = {})
        attributes = { 'text': attributes[:text] }

        API::Client.create(:call_script, attributes)
      end

    end
  end
end

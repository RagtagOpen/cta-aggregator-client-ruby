require 'cta_aggregator_client/cta_resource'

module CTAAggregatorClient
  module Event
    extend CTAResource

    RESOURCE_NAME = :event
    RELATIONSHIPS = :location

    class << self

      def resource_name
        RESOURCE_NAME
      end

      def relationships
        RELATIONSHIPS
      end

    end
  end
end

require 'cta_aggregator_client/cta_resource'

module CTAAggregatorClient
  module Event
    extend CTAResource

    RESOURCE_NAME = :event

    class << self

      def resource_name
        RESOURCE_NAME
      end

    end
  end
end

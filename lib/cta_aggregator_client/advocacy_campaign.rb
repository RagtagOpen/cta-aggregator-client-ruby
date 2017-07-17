require 'cta_aggregator_client/cta_resource'

module CTAAggregatorClient
  module AdvocacyCampaign
    extend CTAResource

    RESOURCE_NAME = :advocacy_campaign

    class << self

      def resource_name
        RESOURCE_NAME
      end

    end
  end
end

require 'cta_aggregator_client/configuration'
require 'cta_aggregator_client/api/client'
require 'cta_aggregator_client/advocacy_campaign'
require 'cta_aggregator_client/target'
require 'cta_aggregator_client/event'
require 'cta_aggregator_client/location'

module CTAAggregatorClient

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end

require 'cta_aggregator_client/configuration'
require 'cta_aggregator_client/cta'
require 'cta_aggregator_client/contact'
require 'cta_aggregator_client/location'
require 'cta_aggregator_client/call_script'
require 'cta_aggregator_client/api/client'

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

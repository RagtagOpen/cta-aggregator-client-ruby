require 'cta_aggregator_client'
require 'shared_examples/listable_resource'
require 'shared_examples/findable_resource'
require 'shared_examples/creatable_resource'
require 'helpers/test_helpers'
require 'factory'
require 'pry'

RSpec.configure do |config|
  config.before(:all) do
    CTAAggregatorClient.configure do |config|
      config.base_url = 'localhost'
      config.api_version = 'v1'
    end
  end

  config.raise_errors_for_deprecations!

  config.order = 'random'

  config.include TestHelpers
end

module CTAAggregatorClient
  class Configuration

    attr_accessor :base_url, :api_version

    def initialize
      @base_url = nil
      @api_version = nil
    end

  end
end

module CTAAggregatorClient
  class Configuration

    attr_accessor :base_url, :api_version, :api_key, :api_secret

    def initialize
      @base_url = nil
      @api_version = nil
      @api_key = nil
      @api_secret = nil
    end

  end
end

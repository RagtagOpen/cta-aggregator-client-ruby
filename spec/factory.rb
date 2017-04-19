require 'rspec'

module Factory

  class << self

    def response
      CTAAggregatorClient::Response.new(
        code: 200,
        body: 'hello, world',
        headers: { content_type: 'application/vnd.api+json' }
      )
    end

  end
end

module UHelpers

  def base_url
    "#{CTAAggregatorClient::configuration.base_url}/#{CTAAggregatorClient.configuration.api_version}"
  end

end

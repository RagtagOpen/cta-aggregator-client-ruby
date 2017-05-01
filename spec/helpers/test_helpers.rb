module TestHelpers

  # Coerces a class name into pluralized resource name 
  # e.g. "CTAAggregatorClient::CallScript" to "call-scripts" 
  def formatted_resource_name(klass, hardcoded_klass_name)
    resource_name = "#{(hardcoded_klass_name || klass.name.split("::")[1].split(/(?=[A-Z])/).map { |class_name_part| class_name_part.downcase }.join('_'))}s"
  end

  def api_url
    "#{CTAAggregatorClient::configuration.base_url}/#{CTAAggregatorClient.configuration.api_version}"
  end

  def auth_url
    "#{api_url}/authorize"
  end

  def headers_with_auth_creds
    CTAAggregatorClient::API::Authenticator.default_headers.merge(
      authorization: auth_info
    )
  end

  def auth_info
    "#{CTAAggregatorClient.configuration.api_key}:#{CTAAggregatorClient.configuration.api_secret}"
  end
end

module TestHelpers

  # Coerces a class name into pluralized resource name 
  # e.g. "CTAAggregatorClient::CallScript" to "call-scripts" 
  def formatted_resource_name(klass, hardcoded_klass_name)
    resource_name = "#{(hardcoded_klass_name || klass.name.split("::")[1].split(/(?=[A-Z])/).map { |class_name_part| class_name_part.downcase }.join('_'))}s"
  end

  def api_url
    "#{CTAAggregatorClient::configuration.base_url}/#{CTAAggregatorClient.configuration.api_version}"
  end
end

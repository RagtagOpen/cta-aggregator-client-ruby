lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cta_aggregator_client/version'

Gem::Specification.new do |s|
  s.name        = 'cta_aggregator_client'
  s.version     = CTAAggregatorClient::VERSION
  s.date        = '2017-04-18'
  s.summary     = 'Ruby Client for CTA Aggregator'
  s.authors     = ['Ben Downey']
  s.email       = 'ben@buildingblocklabs.com'
  s.homepage    = 'https://github.com/Ragtagteam/cta-aggregator-client-ruby' 
  s.license       = 'MIT'
  s.require_path = 'lib'
  s.files        = Dir['lib/**/*']
  s.test_files   = Dir['spec/**/*']
  s.add_dependency 'rest-client', '2.0.1'
  s.add_development_dependency 'pry', '0.9.12.2'
  s.add_development_dependency 'rspec', '3.5.0'
end

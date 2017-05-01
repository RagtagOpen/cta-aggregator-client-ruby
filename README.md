# CTAAggregator Client

This gem provides a simple interface for interacting with the CTAAggregator API.

API actions for listing calls to action or viewing an individual
call to action require no authentication.  However, creating resources does.

You'll need to register your app with Ragtag.  You'll receive your API key and secret.

Once you've got these credentials, this gem will take care of the rest.
When making API requests that require authentication, this gem will request a
JSON Web Token from the authentication endpoint and then pass it along during
requests to the endpoint you care about.

## Getting started

You can add this to your Gemfile.

gem 'cta_aggregator_client'

Then run bundle install.

Next, you'll need to configure the client.  All API calls will fail unless you've set
* `base_url` 
* `api_version`  

API calls that create or add a resoruce will fail if these values are not set:
* `api_key` 
* `api_secret`  

Here's an example of how to configure your client.

```
# config/intitalizers/cta_aggregator_client.rb

CTAAggregatorClient.configure do |config|
  config.base_url = ENV['CTA_AGGREGATOR_HOST'] # => 'localhost:3000', staging url or production url
  config.api_version = ENV['CTA_AGGREGATOR_VERSION']  # => probably 'v1'
  config.api_key = ENV['CTA_AGGREGATOR_KEY'] # => whatever your key is
  config.api_secret = ENV['CTA_AGGREGATOR_SECRET'] # => whatever your key is
end
```


## Usage

Here are a few examples of how you might use this gem.

### CTAs

 list all CTAs
```
CTAAggregatorClient::CTA.list
```

list upcoming CTAs
```
CTAAggregatorClient::CTA.list(upcoming: true)
```
    
Find a CTA
```
CTAAggregatorClient::CTA.find("some-uuid")
```


Create a CTA
Note: you will have to have an API Key and Secret in order to create a CTA
```
attributes = {
  title: 'cool thing',
  descrition: 'blah, blah, blah',
  website: 'www.example.com',
  cta_type: "onsite",
  free: true,
  start_time: 1524175800,
  end_time: 1524186600,
  location_id: "df4aec9f-2ee9-4f53-8708-d32ad2c3babb",
  contact_id: "be7ba220-47b4-4450-b863-57b82481f2a9" 
  call_script_id: "df62fbda-93b3-4f34-8a4c-5bf84564b699"
}

CTAAggregatorClient::CTA.create(attributes)
```

### Contacts

 list all Contacts
```
CTAAggregatorClient::Contact.list
```

Find a Contact
```
CTAAggregatorClient::Contact.find("some-uuid")
```


Create a Contact
Note: you will have to have an API Key and Secret in order to create a CTA
```
attributes = {
  name: 'George Washington',
  email: 'NumeroUno@potus.gov'
}

CTAAggregatorClient::Contact.create(attributes)
```

### Locations

list all Locations
```
CTAAggregatorClient::Location.list
```

Find a Location
```
CTAAggregatorClient::Location.find("some-uuid")
```


Create a Location
Note: you will have to have an API Key and Secret in order to create a CTA
```
attributes = {
  addres: '123 Fake Street',
  zipcode: '12345'
}

CTAAggregatorClient::Location.create(attributes)
```

### Call Scripts

list all Call Scripts
```
CTAAggregatorClient::CallScript.list
```

Find a Contact
```
CTAAggregatorClient::CallScript.find("some-uuid")
```


Create a Contact
Note: you will have to have an API Key and Secret in order to create a CTA

```
attributes = {
  text: 'Hello World.'
}

CTAAggregatorClient::CallScript.create(attributes)
```


# CTAAggregator Client

This gem provides a simple interface for interacting with the CTAAggregator API.


## Getting started

You can add this to your Gemfile with:

gem 'cta_aggregator_client'
Then run bundle install

Next, you'll need to configure the client.  API calls will fail unless you've set the `base_url` and `api_version`.  


```
# config/intitalizers/cta_aggregator_client.rb

CTAAggregatorClient.configure do |config|
  config.base_url = 'localhost:3000' # (or staging url or production url
  config.api_version = 'v1'
end
```

You'll probably want to store the `base_url` and `api_version` as environment variables.


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


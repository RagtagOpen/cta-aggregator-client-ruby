# CTAAggregator Client

This gem provides a simple interface for interacting with the CTAAggregator API.

API actions for listing calls to action or viewing an individual
call to action require no authentication.  However, creating resources does.

If you want to create or create a connection between resources, you'll need 
an API key and secret.  To get these, to send an email to 
`ctaaggregator@ragtag.org`.

Once you've got these credentials, this gem will take care exchanging them for
a JSON Web Token (JWT) from the authentication endpoint and then pass it along during
requests to the endpoint(s) you care about.

## Getting started

You can add this to your Gemfile.

gem 'cta_aggregator_client'

Then run bundle install.

Next, you'll need to configure the client.  All API calls will fail unless you've set
* `base_url` 
* `api_version`  

API calls that create or add a resource will fail if these values are not set:
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

### Advocacy Campaigns

list all Advocacy Campaigns
```
CTAAggregatorClient::AdvocacyCampaign.list
```

Find an Advocacy Campaign
```
CTAAggregatorClient::AdvocacyCampaign.find("some-uuid")
```

Create an Advocacy Campaign
Note: you will have to have an API Key and Secret in order to create this resource
```
attributes = {
  title: 'Email Your Congressional reps',
  description: 'Voluptas delectus distinctio maiores consequatur aspernatur.',
  browser_url: 'http://example.com/nya.lang',
  origin_system: 'FooCalls',
  featured_image_url: 'http://www.example.com/nya/300x300.png',
  action_type: 'email',
  template: 'Eum itaque et nisi dolores assumenda ipsum. Voluptates qui aut nobis veniam maxime qui',
}

relationships = { targets: ['a2f6f86b-a214-4892-8c06-8caece820fb0', '215ed993-3cd1-4fbc-b8af-7e2082813d06'] }
# Note that because an Advocacy can have many relationships, be sure to send an array of targets, even if there's only one
# e.g. relationships = { targets: ['a2f6f86b-a214-4892-8c06-8caece820fb0'] }

CTAAggregatorClient::CTA.create(attributes, relationships)
```

Update an Advocacy Campaign
If you attempt to update a resource created by someone else, the API will return a 403 Unauthorized response.

```
# Pass along the id and any attributes you want to change.
attributes = {
  id: 'some-uuid'
  title: 'New title',
}
CTAAggregatorClient::AdvocacyCampaign.update(attributes)
```

###  Events

list all Events
```
CTAAggregatorClient::Event.list
```

list upcoming Events
```
CTAAggregatorClient::Event.list(upcoming: true)
```

Find an Event
```
CTAAggregatorClient::Event.find("some-uuid")
```


Create a Event
Note: you will have to have an API Key and Secret in order to create a CTA
```
attributes = {
  title: 'March on Washington',
  description: 'Illum molestiae aut ullam non qui consequatur magni.',
  browser_url: 'http://example.com/marge',
  origin_system: '5Calls',
  featured_image_url: 'http://lorempixel.com/300/300',
  start_date: '2017-07-08T03:58:25.098Z',
  end_date: '2017-07-13T03:58:25.098Z',
  free: false,
}
relationships = { location: '215ed993-3cd1-4fbc-b8af-7e2082813d06' }
# Note that because an Event only has one location, so be sure your hash has a key of `location`, rather than `locations`

CTAAggregatorClient::Event.create(attributes, relationships)
```

Update an Event
Note: you can only update a resource that you were responsible for creating.
If you attempt to update a resource created by someone else, the API will return a 403 Unauthorized response.
```
# Pass along the id and any attributes you want to change.
attributes = {
  id: 'some-uuid'
  title: 'New title',
}
CTAAggregatorClient::Event.update(attributes)
```

### Targets

list all Targets
```
CTAAggregatorClient::Target.list
```

Find a Target
```
CTAAggregatorClient::Target.find("some-uuid")
```


Create a Target
Note: you will have to have an API Key and Secret in order to create a Target
```
attributes = {
  organization: 'Mohr Inc',
  given_name: 'Pascale',
  family_name: 'White',
  ocdid: 'b4503418-6aab-451a-8e55-11ffd575bc85',
  postal_addresses: [
  {
    primary: true,
    address_type: 'Office',
    venue: 'Southern Nitzsche',
    address_lines: [
      '36261 Kovacek Prairie',
      'Apt. 760'
    ],
    locality: 'West Brandynfort',
    region: 'WV',
    postal_code: '66900-1309',
    country: 'US'
     }
  ],
  email_addresses: [
    {
      primary: true,
      address: 'jeffry_durgan@rutherfordcarroll.net',
      address_type: 'work'
     }
  ],
  phone_numbers: [
     {
       primary: true,
       number: '(606) 087-8543 x254',
       extension: '4594',
       number_type: 'work'
      }
    ]
  }
}

CTAAggregatorClient::Target.create(attributes)
```

Update a Target
Note: you can only update a resource that you were responsible for creating.
If you attempt to update a resource created by someone else, the API will return a 403 Unauthorized response.
```
# Pass along the id and any attributes you want to change.
attributes = {
  id: 'some-uuid'
  'organization': "FCC"
}
CTAAggregatorClient::Target.update(attributes)
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
  venue: 'Eastern Kemmer University',
  address_lines: ['684 Schinner Trail', 'Apt. 512'],
  locality: 'Rosenbaumville',
  region: 'VA',
  postal_code: '78183-3430'
}

CTAAggregatorClient::Location.create(attributes)
```

Update a Location
Note: you can only update a resource that you were responsible for creating.
If you attempt to update a resource created by someone else, the API will return a 403 Unauthorized response.
```
# Pass along the id and any attributes you want to change.
attributes = {
  id: 'some-uuid'
  venue: 'National Mall',
}
CTAAggregatorClient::Location.update(attributes)
```

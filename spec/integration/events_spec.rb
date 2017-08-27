require 'spec_helper'

describe CTAAggregatorClient::Event do

  it_behaves_like 'listable resource'
  it_behaves_like 'findable resource'
  it_behaves_like 'updatable resource'
  it_behaves_like 'deletable resource'

  context 'creation' do
    event_attrs = {
      title: 'March on Washington',
      description: 'Illum molestiae aut ullam non qui consequatur magni.',
      browser_url: 'http://example.com/marge',
      origin_system: '5Calls',
      featured_image_url: 'http://lorempixel.com/300/300',
      start_date: '2017-07-08T03:58:25.098Z',
      end_date: '2017-07-13T03:58:25.098Z',
      free: false,
    }
    relationship_attrs = { location: '215ed993-3cd1-4fbc-b8af-7e2082813d06' }

    it_behaves_like 'creatable resource', event_attrs, relationship_attrs
  end

end

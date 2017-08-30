require 'spec_helper'

describe CTAAggregatorClient::AdvocacyCampaign do

  it_behaves_like 'listable resource'
  it_behaves_like 'findable resource'
  it_behaves_like 'updatable resource'
  it_behaves_like 'deletable resource'

  context 'creation' do
    campaign_attrs = {
      title: 'Email Congressman - 1',
      description: 'Voluptas delectus distinctio maiores consequatur aspernatur.',
      browser_url: 'http://example.com/nya.lang',
      origin_system: '5Calls',
      featured_image_url: 'http://lorempixel.com/300/300',
      action_type: 'email',
      template: 'Eum itaque et nisi dolores assumenda ipsum. Voluptates qui aut nobis veniam maxime qui. Illum saepe eum corporis vero qui soluta aliquam.\nTemporibus reiciendis velit fugiat. Facere laborum quia ea laboriosam necessitatibus quisquam eligendi. Et est dolorem eligendi id aut sint.\nAnimi qui totam voluptatem nesciunt iure et dolorem. Eos ut dolorum et quo illum fuga atque. Facere a ipsa corrupti assumenda provident commodi facilis. Eligendi officia est et.',
    }
    relationship_attrs = { targets: ['a2f6f86b-a214-4892-8c06-8caece820fb0', '215ed993-3cd1-4fbc-b8af-7e2082813d06'] }

    it_behaves_like 'creatable resource', campaign_attrs, relationship_attrs
  end
end

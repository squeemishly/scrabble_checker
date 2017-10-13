require 'rails_helper'

RSpec.describe 'a user can see waht words are available from their tiles' do
  context 'a user has no wild cards' do
    it 'does a basic word search' do
      visit '/'
      # As a user
      # When I select 'Word Searcher' from the menu
      click_on 'Word Finder'
      expect(page).to have_content 'See All Available Words'
      # Then I should see 'See All Available Words' next to the search box
      # And when I click in the search box
      # And when I type in 'on'
      fill_in :search, with: 'on'
      # And when I click on 'Submit'
      click_on 'Submit'
      # Then I should 'You can make 2 words from your tiles'
      expect(page).to have_content 'You can make 2 words from your tiles'
      # And I should see 'on'
      expect(page).to have_content 'on'
      # And I should see 'no'
      expect(page).to have_content 'no'
    end
  end
end

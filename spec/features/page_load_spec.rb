require 'rails_helper'

RSpec.describe('a use can access the welcome page') do
  it('a user can find definitions of valid words') do
    VCR.use_cassette('verify_results') do
      # as a user
      # when I visit /
      visit '/'
      # and I see a search field
      # and I click in the search field
      # and I type in "best"
      fill_in :search, with: "best"
      # and I click on Submit
      click_on "Submit"
      # and the current path should be /search
      expect(current_path).to eq '/search'
      # Then I should see a confirmation that "best" exists
      expect(page).to have_content "best exists"
      # and I should see a definition for best
      expect(page).to have_content "Definitions: "
    end
  end

  it 'a user gets an error for an invalid word' do
    VCR.use_cassette('invalid_word_search') do
      visit '/'
      fill_in :search, with: 'arstoien'
      click_on "Submit"
      expect(page).to_not have_content 'arstoien exists'
      expect(page).to have_content 'arstoien does not exist'
    end
  end
end

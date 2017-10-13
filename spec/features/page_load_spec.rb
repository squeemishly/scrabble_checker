require 'rails_helper'

RSpec.describe('a use can access the welcome page') do
  it('a user can find definitions of valid words') do
    VCR.use_cassette('verify_results') do
      visit '/'
      fill_in :search, with: "best"
      click_on "Submit"
      expect(current_path).to eq '/search'
      expect(page).to have_content "best exists"
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

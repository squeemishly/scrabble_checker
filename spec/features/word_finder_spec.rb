require 'rails_helper'

RSpec.describe 'a user can see waht words are available from their tiles' do
  context 'a user has no wild cards' do
    it 'does a basic word search' do
      VCR.use_cassette 'anagram_basics' do
        visit '/'
        click_on 'Word Finder'
        expect(page).to have_content 'See All Available Words'
        fill_in :search, with: 'on'
        click_on 'Submit'
        expect(page).to have_content 'You can make 2 words from your tiles'
        expect(page).to have_content 'on'
        expect(page).to have_content 'no'
      end
    end

    it 'does a longer word search' do
      VCR.use_cassette 'longer_anagram' do
        visit '/'
        click_on 'Word Finder'
        expect(page).to have_content 'See All Available Words'
        fill_in :search, with: 'kitty'
        click_on 'Submit'
        expect(page).to have_content 'You can make 5 words from your tiles'
        expect(page).to have_content 'it'
        expect(page).to have_content 'ti'
        expect(page).to have_content 'kit'
        expect(page).to have_content 'tit'
        expect(page).to have_content 'kitty'
      end
    end
  end
end

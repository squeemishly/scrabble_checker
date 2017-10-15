require 'rails_helper'

RSpec.describe Finder do
  context '.all_words' do
    it 'returns an empty array when it has no tiles' do
      VCR.use_cassette 'finder_empty_string' do
        words = Finder.all_words('')
        expect(words).to eq []
      end
    end

    it 'returns all 2 letter anagrams for 2 tiles' do
      VCR.use_cassette 'finder_2_tiles' do
        words = Finder.all_words('no')
        expect(words.count).to eq 2
        expect(words).to eq ['no', 'on']
      end
    end

    it 'returns all 2 and 3 letter anagrams for 3 tiles' do
      VCR.use_cassette 'finder_3_tiles' do
        words = Finder.all_words('not')
        expect(words.count).to eq 5
        expect(words).to eq ['no', 'on', 'to', 'not', 'ton']
      end
    end
  end
end

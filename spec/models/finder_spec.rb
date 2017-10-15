require 'rails_helper'

RSpec.describe Finder do
  context '.all_words' do
    it 'returns all 2 letter anagrams for 2 tiles' do
      VCR.use_cassette 'finder_2_tiles' do
        words = Finder.all_words('no')
        expect(words).to be_a Array
        expect(words.first).to be_a String
        expect(words.count).to eq 2
        expect(words).to eq ['no', 'on']
      end
    end

    it 'returns all 2 and 3 letter anagrams for 3 tiles' do
      VCR.use_cassette 'finder_3_tiles' do
        words = Finder.all_words('not')
        expect(words.all? { |word| word.length > 1 }).to be true
        expect(words.count).to eq 5
        expect(words).to eq ['no', 'on', 'to', 'not', 'ton']
      end
    end

    it 'returns all anagrams from 4 tiles' do
      VCR.use_cassette 'finder_4_tiles' do
        words = Finder.all_words('arst')
        expect(words.count).to eq 15
        expect(words).to eq ["as", "at", "rs", "ts", "as", "art", "rat", "tar", "sat", "rs", "arts", "rats", "star", "tars", "tsar"]
      end
    end
  end
end

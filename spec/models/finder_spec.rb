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
        expect(words.count).to eq 13
        expect(words).to eq ["as", "at", "rs", "ts", "art", "rat", "tar", "sat", "arts", "rats", "star", "tars", "tsar"]
      end
    end

    it 'only returns a single instance of each word' do
      VCR.use_cassette 'finder_remove_duplicates' do
        words = Finder.all_words('kitty')
        expect(words.count).to eq 5
        expect(words).to eq ['it', 'ti', 'kit', 'tit', 'kitty']
      end
    end
  end

  context '.verify_word_length' do
    it 'only keeps words that have more than 1 character' do
      VCR.use_cassette 'finder_verify_word_length' do
        words = Finder.verify_word_length('arst')
        expect(words).to be_a Array
        expect(words.all? { |word| word.length > 1 }).to be true
      end
    end
  end

  context '.anagramify' do
    it 'makes a list of words from tiles' do
      VCR.use_cassette 'finder_anagramify' do
        words = Finder.anagramify('arst')
        expect(words).to be_a Array
        expect(words.first).to be_a String
        expect(words.length).to eq 17
        expect(words).to eq ["a", "as", "at", "rs", "r", "ts", "as", "art", "rat", "tar", "sat", "rs", "arts", "rats", "star", "tars", "tsar"]
      end
    end
  end

  context '.make_list' do
    it 'makes a list of tile combinations with 2 tiles' do
      list = Finder.make_list('ar')
      expect(list).to be_a Array
      expect(list.first).to be_a Array
      expect(list.count).to eq 1
      expect(list).to eq [['a', 'r']]
    end

    it 'makes a list of tile combinations with many tiles' do
      list = Finder.make_list('arst')
      expect(list).to be_a Array
      expect(list.first).to be_a Array
      expect(list.count).to eq 11
      expect(list).to eq [["a", "r"], ["a", "s"], ["a", "t"], ["r", "s"], ["r", "t"], ["s", "t"], ["a", "r", "s"], ["a", "r", "t"], ["a", "s", "t"], ["r", "s", "t"], ["a", "r", "s", "t"]]
    end
  end
end

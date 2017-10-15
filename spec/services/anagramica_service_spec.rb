require 'rails_helper'

RSpec.describe AnagramicaService do
  let(:ags) { AnagramicaService.new }

  context 'initialize' do
    it 'has a url' do
      expect(ags.url).to eq "http://www.anagramica.com"
    end
  end

  context '.get_words' do
    it 'returns a list of anagrams for 2 letters' do
      VCR.use_cassette 'anagramica_service_get_words_2_letters' do
        words = AnagramicaService.get_words('no')
        words_list = JSON.parse(words.body)
        expect(words_list).to be_a Hash
        expect(words_list["best"]).to be_a Array
        expect(words_list["best"].count).to eq 2
        expect(words_list["best"]).to eq ['no', 'on']
      end
    end

    it 'returns a list of 4 letter words for 4 tiles' do
      VCR.use_cassette 'anagramica_service_4_letters' do
        words = AnagramicaService.get_words('note')
        words_list = JSON.parse(words.body)
        expect(words_list).to be_a Hash
        expect(words_list["best"]).to be_a Array
        expect(words_list["best"].count).to eq 2
        expect(words_list["best"]).to eq ['note', 'tone']
      end
    end
  end

  context '#best' do
    it 'returns a list of 2 letter words for 2 tiles' do
      VCR.use_cassette 'anagramica_best_2_letters' do
        words = ags.best('no')
        words_list = JSON.parse(words.body)
        expect(words_list).to be_a Hash
        expect(words_list["best"]).to be_a Array
        expect(words_list["best"].count).to eq 2
        expect(words_list["best"]).to eq ['no', 'on']
      end
    end
  end
end

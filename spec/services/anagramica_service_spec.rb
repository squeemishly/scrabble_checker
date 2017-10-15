require 'rails_helper'

RSpec.describe AnagramicaService do
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
  end
end

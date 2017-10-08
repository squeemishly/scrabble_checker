require 'rails_helper'

RSpec.describe Search do
  context '.find_word' do
    it 'returns an array of definitions' do
      VCR.use_cassette('Search_find_word') do
        defs = Search.find_word('hammer')
        expect(defs).to be_a Array
        expect(defs.first).to be_a String
      end
    end
  end
end

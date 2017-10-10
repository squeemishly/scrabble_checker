require 'rails_helper'

RSpec.describe OedService do
  context 'building blocks' do
    it 'knows its url' do
      oed = OedService.new
      expect(oed.url).to eq "https://od-api.oxforddictionaries.com:443"
    end
  end
end

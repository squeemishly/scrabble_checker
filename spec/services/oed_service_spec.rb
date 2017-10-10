require 'rails_helper'

RSpec.describe OedService do
  context 'building blocks' do
    it 'knows its url' do
      oed = OedService.new
      expect(oed.url).to eq "https://od-api.oxforddictionaries.com:443"
    end
  end

  context 'class methods' do
    it '.find_word' do
      VCR.use_cassette('oed_service_class_find_word') do
        res = OedService.find_word("test")
        oed = JSON.parse(res.body)
        expect(oed).to be_a Hash
        expect(oed).to have_key "results"
        expect(oed["results"][0]).to have_key "lexicalEntries"
        expect(oed["results"][0]["lexicalEntries"][0]).to have_key "entries"
        expect(oed["results"][0]["lexicalEntries"][0]["entries"][0]).to have_key "senses"
        expect(oed["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]).to have_key "definitions"
        expect(oed["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"]).to be_a Array
        expect(oed["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"][0]).to be_a String
      end
    end
  end

  context 'instance methods' do
    it '#find_word' do
      VCR.use_cassette('oed_service_instance_find_word') do
        oed = OedService.new
        res = oed.find_word("another")
        results = JSON.parse(res.body)
        expect(results).to be_a Hash
        expect(results).to have_key "results"
        expect(results["results"][0]).to have_key "lexicalEntries"
        expect(results["results"][0]["lexicalEntries"][0]).to have_key "entries"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]).to have_key "senses"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]).to have_key "definitions"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"]).to be_a Array
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"][0]).to be_a String
      end
    end

    it '#oed_call' do
      VCR.use_cassette('oed_service_oed_call') do
        oed = OedService.new
        url = "https://od-api.oxforddictionaries.com:443"
        res = oed.instance_eval { oed_call(Faraday.new(url: url), "third") }
        results = JSON.parse(res.body)
        expect(results).to be_a Hash
        expect(results).to have_key "results"
        expect(results["results"][0]).to have_key "lexicalEntries"
        expect(results["results"][0]["lexicalEntries"][0]).to have_key "entries"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]).to have_key "senses"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]).to have_key "definitions"
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"]).to be_a Array
        expect(results["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["definitions"][0]).to be_a String
      end
    end
  end
end

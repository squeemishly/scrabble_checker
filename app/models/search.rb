class Search < ActiveRecord::Base
  def self.find_word(word)
    conn = Faraday.new(url: "https://od-api.oxforddictionaries.com:443")
    response = conn.get "/api/v1/entries/en/#{word}",
                    {},
                    {
                      'app_id' => ENV['oxford_dictionary_app_id'],
                      'app_key' => ENV['oxford_dictionary_app_key']
                    }
    res = JSON.parse(response.body)
    initial_defs = res['results'].first['lexicalEntries'].first['entries'].first['senses'].first['definitions']
    sub_defs = res['results'].first['lexicalEntries'].first['entries'].first['senses'].first['subsenses'].map do |definition|
      definition['definitions']
    end
    [initial_defs, sub_defs].flatten
  end
end

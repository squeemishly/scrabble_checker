class OedService
  def self.find_word(word)
    conn = Faraday.new(url: "https://od-api.oxforddictionaries.com:443")
    conn.get "/api/v1/entries/en/#{word}",
              {},
              {
                'app_id' => ENV['oxford_dictionary_app_id'],
                'app_key' => ENV['oxford_dictionary_app_key']
              }
  end
end

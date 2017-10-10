class OedService
  attr_reader :url

  def initialize
    @url = "https://od-api.oxforddictionaries.com:443"
  end

  def self.find_word(word)
    new.find_word(word)
  end

  def find_word(word)
    conn = Faraday.new(url: url)
    oed_call(conn, word)
  end

  private

  def oed_call(conn, word)
    conn.get "/api/v1/entries/en/#{word}",
              {},
              {
                'app_id' => ENV['oxford_dictionary_app_id'],
                'app_key' => ENV['oxford_dictionary_app_key']
              }
  end
end

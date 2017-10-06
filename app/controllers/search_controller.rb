class SearchController < ApplicationController
  def index
    conn = Faraday.new(url: "https://od-api.oxforddictionaries.com:443")
    response = conn.get "/api/v1/entries/en/best",
                        {},
                        {
                          'app_id' => ENV['oxford_dictionary_app_id'],
                          'app_key' => ENV['oxford_dictionary_app_key']
                        }
  end
end

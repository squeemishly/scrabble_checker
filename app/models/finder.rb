class Finder
  def self.all_words(tiles)
    if tiles == ''
      []
    else
      response = Faraday.get("http://www.anagramica.com/best/#{tiles}")
      JSON.parse(response.body)["best"]
    end
  end
end

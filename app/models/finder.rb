class Finder
  def self.all_words(tiles)
    if tiles == ''
      []
    else
      response = Faraday.get("http://www.anagramica.com/best/#{tiles}")
      binding.pry
    end
  end
end

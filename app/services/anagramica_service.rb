class AnagramicaService
  def self.get_words(letters)
    Faraday.get("http://www.anagramica.com/best/#{letters}")
  end
end

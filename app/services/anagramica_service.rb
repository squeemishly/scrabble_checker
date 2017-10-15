class AnagramicaService
  attr_reader :url

  def initialize
    @url = "http://www.anagramica.com"
  end

  def self.get_words(letters)
    new.best(letters)
  end

  def best(letters)
    Faraday.get("#{url}/best/#{letters}")
  end
end

class Finder
  def self.all_words(tiles)
    self.verify_word_length(tiles).uniq
  end

  private

  def self.verify_word_length(tiles)
    self.anagramify(tiles).keep_if { |word| word.length > 1 }
  end

  def self.anagramify(tiles)
    self.make_list(tiles).map do |letters|
      response = AnagramicaService.get_words(letters.join(''))
      JSON.parse(response.body)["best"]
    end.flatten
  end

  def self.make_list(tiles)
    tiles_list = tiles.split('')
    tiles_combined = []
    i = 2
    while i <= tiles_list.length do
      tiles_combined << tiles_list.combination(i).to_a
      i += 1
    end
    tiles_combined.flatten(1)
  end
end

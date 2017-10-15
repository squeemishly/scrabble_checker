class Finder
  def self.all_words(tiles)
    if tiles == ''
      []
    else
      result = []
      tiles_list = tiles.split('')
      tiles_combined = []
      i = 2
      while i <= tiles_list.length do
        tiles_combined << tiles_list.combination(i).to_a
        i += 1
      end
      thing = tiles_combined.flatten(1).map do |letters|
        response = Faraday.get("http://www.anagramica.com/best/#{letters.join('')}")
        JSON.parse(response.body)["best"]
      end.flatten.keep_if { |word| word.length > 1 }
    end
  end
end

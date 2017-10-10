class Search
  def self.find_word(word)
    response = OedService.find_word(word)
    res = JSON.parse(response.body)
    self.build_defs(res)
  end

  private

  def self.build_defs(res)
    arr = []
    res['results'].first['lexicalEntries'].each do |lex_entry|
      self.find_entries(lex_entry, arr)
    end
    arr.flatten.compact
  end

  def self.find_entries(lex_entry, arr)
    lex_entry["entries"].each do |entry|
      self.find_defs(entry, arr)
    end
    arr
  end

  def self.find_defs(entry, arr)
    entry["senses"].each do |sense|
      arr << sense["definitions"]
    end
    arr
  end
end

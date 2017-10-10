class Search
  def self.find_word(word)
    response = OedService.find_word(word)
    res = JSON.parse(response.body)
    self.build_defs(res)
  end

  private

  def self.build_defs(res)
    self.parse_results(res).flatten.compact
  end

  def self.parse_results(res)
    res['results'].first['lexicalEntries'].map do |lex_entry|
      self.parse_entries(lex_entry)
    end
  end

  def self.parse_entries(lex_entry)
    lex_entry["entries"].map do |entry|
      self.find_defs(entry)
    end
  end

  def self.find_defs(entry)
    entry["senses"].map do |sense|
      sense["definitions"]
    end
  end
end

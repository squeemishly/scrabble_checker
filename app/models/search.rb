class Search
  def self.find_word(word)
    response = OedService.find_word(word)
    self.verify_response_status(response)
  end

  private

  def self.verify_response_status(response)
    if response.status == 404
      nil
    elsif response.status == 200
      res = JSON.parse(response.body)
      self.build_defs(res)
    end
  end

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

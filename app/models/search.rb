class Search
  def self.find_word(word)
    response = OedService.find_word(word)
    res = JSON.parse(response.body)
    self.build_defs(res)
  end

  private

  def self.find_primary_defs(res)
    res['results'].first['lexicalEntries'].first['entries'].first['senses'].first['definitions']
  end

  def self.find_sub_defs(res)
    res['results'].first['lexicalEntries'].first['entries'].first['senses'].first['subsenses'].map do |definition|
      definition['definitions']
    end
  end

  def self.build_defs(res)
    [find_primary_defs(res), find_sub_defs(res)].flatten.compact
  end
end

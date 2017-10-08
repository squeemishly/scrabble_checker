class SearchController < ApplicationController
  def index
    @word = params["search"]
    @definitions = Search.find_word(@word)
  end
end

class FinderController < ApplicationController
  def index
    @tiles = params["search"]
    @words = Finder.all_words(@tiles)
  end
end

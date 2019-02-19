class WordRootsController < ApplicationController
  def index
    @word_roots = WordRoot.includes(:words).paginate(:page => params[:page], :per_page => 5)
    #.offset(offset).limit(5)
  end
end

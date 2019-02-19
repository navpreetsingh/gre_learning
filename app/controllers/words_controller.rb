class WordsController < ApplicationController
  before_action :set_word, only: [:show]
  def show
    @additional_info = @word.additional_info
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end
end

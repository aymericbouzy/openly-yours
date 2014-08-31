class LettersController < ApplicationController
  before_action :set_letter, only: [:show]

  # GET /letters
  # GET /letters.json
  def index
    @letters = Letter.where(rough_draft: false)
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.where(id: params[:id], rough_draft: false)
    end
end

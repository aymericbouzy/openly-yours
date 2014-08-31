class Users::LettersController < Users::BaseController
  before_action :set_letter, only: [:show]

  # GET /users/letters
  # GET /users/letters.json
  def index
    @letters = @user.letters.where(rough_draft: false)
  end

  # GET /users/letters/1
  # GET /users/letters/1.json
  def show
    redirect_to letter_path(@letter)
  end

  def followed
    @letters = @user.followed_letters.sort { |x, y| y.created_at <=> x.created_at }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.where(id: params[:id], rough_draft: false)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params[:letter]
    end
end

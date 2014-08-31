class Users::LettersController < ApplicationController
  before_action :set_user
  before_action :set_users_letter, only: [:show]

  # GET /users/letters
  # GET /users/letters.json
  def index
    @users_letters = @user.letters
  end

  # GET /users/letters/1
  # GET /users/letters/1.json
  def show
  end

  def followed
    Letter.where(id: @user.followed_letters)
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_users_letter
      @users_letter = Letter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_letter_params
      params[:users_letter]
    end
end

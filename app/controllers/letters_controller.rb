class LettersController < ApplicationController
  before_action :set_user
  before_action :set_letter, except: [:index]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /letters
  # GET /letters.json
  def index
    @letters = Letter.where(rough_draft: false)
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  def follow
    if current_user.follow(@letter)
      flash[:notice] = "success"
    else
      flash[:alert] = "error"
    end
    render 'show'
  end

  def followers
    @followships = @letter.followships.sort { |x, y| y.created_at <=> x.created_at }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.where(id: params[:id], rough_draft: false)
    end

    def set_user
      if params[:user_id].present?
        @user = User.find(params[:id])
      elsif request.env["PATH_INFO"].split("/").first == "me"
        authenticate_user!
        @user = current_user
      end
    end
end

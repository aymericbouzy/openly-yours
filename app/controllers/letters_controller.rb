class LettersController < ApplicationController
  before_filter :belongs_to_current_user, except: [:index, :show]

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def belongs_to_current_user
    render :unauthorized unless user_signed_in? && current_user.letters.find(params[:id]).present?
  end
end

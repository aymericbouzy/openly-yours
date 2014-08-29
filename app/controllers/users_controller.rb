class UsersController < ApplicationController
  before_filter :find_user, except: [:index]
  def show
  end

  def index
  end

  def letters
  end

  def followed_letters
  end

  private

  def find_user
    @user = User.find(params[:id])
    render '404' if @user.nil?
  end
end

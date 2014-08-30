class Users::LettersController < ApplicationController
  before_action :set_users_letter, only: [:show, :edit, :update, :destroy]

  # GET /users/letters
  # GET /users/letters.json
  def index
    @users_letters = Users::Letter.all
  end

  # GET /users/letters/1
  # GET /users/letters/1.json
  def show
    redirect_to letter_path(@users_letter)
  end

  # GET /users/letters/new
  def new
    @users_letter = Users::Letter.new
  end

  # GET /users/letters/1/edit
  def edit
  end

  # POST /users/letters
  # POST /users/letters.json
  def create
    @users_letter = Users::Letter.new(users_letter_params)

    respond_to do |format|
      if @users_letter.save
        format.html { redirect_to @users_letter, notice: 'Letter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @users_letter }
      else
        format.html { render action: 'new' }
        format.json { render json: @users_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/letters/1
  # PATCH/PUT /users/letters/1.json
  def update
    respond_to do |format|
      if @users_letter.update(users_letter_params)
        format.html { redirect_to @users_letter, notice: 'Letter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @users_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/letters/1
  # DELETE /users/letters/1.json
  def destroy
    @users_letter.destroy
    respond_to do |format|
      format.html { redirect_to users_letters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_letter
      @users_letter = Users::Letter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_letter_params
      params[:users_letter]
    end
end

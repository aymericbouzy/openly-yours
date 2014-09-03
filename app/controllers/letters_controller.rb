class LettersController < ApplicationController
  before_action :set_user
  before_action :set_letter, except: [:index, :followed, :rough_drafts]
  before_action :letter_unpublished_yet!, only: [:edit, :update, :destroy, :publish]
  before_action :authenticate_user!, except: [:index, :show, :follow, :followers, :followed, :rough_drafts]

  # GET /letters
  # GET /letters.json
  # GET /me/letters
  # GET /users/1/letters
  def index
    if @user.present?
      @letters = @user.letters
    else
      @letters = Letter.all
    end
    @letters = @letters.where(rough_draft: false)
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  # GET /me/letters/new
  def new
    @letter = Letter.new
  end

  # GET /me/letters/1/edit
  def edit
  end

  # POST /me/letters
  # POST /me/letters.json
  def create
    @letter = current_user.letters.new(letter_params)
    @letter.rough_draft = true

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @letter }
      else
        format.html { render action: 'new' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /me/letters/1
  # PATCH/PUT /me/letters/1.json
  def update
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /me/letters/1
  # DELETE /me/letters/1.json
  def destroy
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to users_letters_url }
      format.json { head :no_content }
    end
  end

  # GET /letters/1/follow
  def follow
    if current_user.follow(@letter)
      flash[:notice] = "success"
    else
      flash[:alert] = "error"
    end
    render 'show'
  end

  # GET /letters/1/followers
  def followers
    @followships = @letter.followships.sort { |x, y| y.created_at <=> x.created_at }
  end

  # GET /users/1/letters/followed
  # GET /me/letters/followed
  def followed
    @letters = @user.followed_letters.sort { |x, y| y.created_at <=> x.created_at }
    render 'index'
  end

  def publish
    @letter.update(rough_draft: false, published_at: Time.now)
  end

  def rough_drafts
    @letters = @user.rough_drafts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.where(id: params[:id])
    end

    def set_user
      if params[:user_id].present?
        @user = User.find(params[:user_id])
      elsif request.env["PATH_INFO"].split("/")[1] == "me"
        authenticate_user!
        @user = current_user
      end
    end

    def letter_unpublished_yet!
      if @letter.published?
        flash[:alert] = "refused"
        redirect_to letter_path(@letter)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params.require(:letter).permit(:title, :text, :recipient_id)
    end

end

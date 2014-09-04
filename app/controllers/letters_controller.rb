class LettersController < ApplicationController
  before_action :set_user
  before_action :set_letter, except: [:index, :user_index, :me_index, :new, :create, :followed, :rough_drafts]
  before_action :letter_unpublished_yet!, only: [:edit, :update, :destroy, :publish]
  before_action :authenticate_user!, except: [:index, :user_index, :show, :follow, :followers, :followed, :rough_drafts]

  # GET /letters
  # GET /letters.json
  # GET /me/letters
  # GET /users/1/letters
  def index
    @letters = Letter.where(rough_draft: false)
  end

  def user_index
    @letters = @user.letters.where(rough_draft: false)
  end

  def me_index
    @letters = @user.letters.where(rough_draft: false)
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  # GET /me/letters/new
  def new
    @letter = Letter.new(session.delete("letter"))
    @letter.recipient = Recipient.new(name: session.delete("recipient_name"))
  end

  # GET /me/letters/1/edit
  def edit
  end

  # POST /me/letters
  # POST /me/letters.json
  def create
    @letter = current_user.letters.new(letter_params)
    @letter.recipient = find_recipient
    @letter.rough_draft = true

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' and return }
        format.json { render action: 'show', status: :created, location: @letter and return }
      else
        format.html { render action: 'new' and return }
        format.json { render json: @letter.errors, status: :unprocessable_entity and return }
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
  end

  def publish
    if @letter.valid_for_publishing? && @letter.update(rough_draft: false, published_at: Time.now)
      flash[:notice] = "success"
    else
      flash[:alert] = "error"
    end
    render 'show'
  end

  def rough_drafts
    @letters = @user.rough_drafts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find(params[:id])
    end

    def set_user
      if params[:user_id].present?
        @user = User.find(params[:user_id])
      elsif request.env["PATH_INFO"].split("/")[1] == "me"
        authenticate_user!
        @user = current_user
      end
    end

    def find_recipient
      debugger
      recipient_name = params[:letter][:recipient][:name] if params[:letter].present? && params[:letter][:recipient].present?
      if recipient_name.blank?
        flash[:alert] = "Please indicate a recipient."
        render :new and return
      else
        set = Recipient.where(name: recipient_name)
        # case set.count
        # when 0
        #   flash[:warning] = "This recipient does not exist yet. #{link_to "Create it!", new_recipient_path, class: "alert-link"}"
        #   session[:letter] = letter_params
        #   session[:recipient_name] = recipient_name
        #   render :new and return
        # else
        #   recipient = set.first
        # end
        recipient = set.first
      end
      recipient
    end

    def letter_unpublished_yet!
      if @letter.published?
        flash[:alert] = "refused"
        redirect_to letter_path(@letter)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params.require(:letter).permit(:title, :text)
    end

end

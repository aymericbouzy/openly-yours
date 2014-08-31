class Me::LettersController < Me::BaseController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :publish]

  # GET /me/letters
  # GET /me/letters.json
  def index
    @letters = current_user.letters
  end

  # GET /me/letters/1
  # GET /me/letters/1.json
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
    @letter = Letter.new(letter_params)

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

  def followed
    @letters = Letter.where(id: current_user.followed_letters)
  end

  def rough_drafts
    @letters = Letter.where(rough_draft: true)
  end

  def publish
    @letter.update(rough_draft: false)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params[:letter]
    end
end

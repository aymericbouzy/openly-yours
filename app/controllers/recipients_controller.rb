class RecipientsController < ApplicationController
  before_action :set_recipient, only: [:show]

  # GET /recipients
  # GET /recipients.json
  def index
    @recipients = Recipient.all
  end

  # GET /recipients/1
  # GET /recipients/1.json
  def show
  end

  def new
    @recipient = Recipient.new(name: session[:recipient_name])
  end


  # POST /recipients
  # POST /recipients.json
  def create
    @recipient = Recipient.new(recipient_params)

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to new_letter_path, notice: 'Recipient was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipient }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  def letters
    @letters = @recipient.letters
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipient_params
      params.require(:recipient).permit(:name, :categorie)
    end
end

class MesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_me

  # GET /me
  # GET /me.json
  def show
  end

  # GET /me/edit
  def edit
  end

  # PATCH/PUT /me
  # PATCH/PUT /me.json
  def update
    respond_to do |format|
      if @me.update(me_params)
        format.html { redirect_to @me, notice: 'me.notice.profile_successfully_updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @me.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_me
      @me = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def me_params
      params.require(:user).permit(:first_name, :last_name)
    end
end

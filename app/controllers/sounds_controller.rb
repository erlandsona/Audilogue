class SoundsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sound = Sound.new
    @sounds = current_user.sounds.order("created_at DESC").page(params[:page]).per(PER_PAGE)
  end

  def create
    @sound = current_user.sounds.new(sound_params)
    respond_to do |format|
      if @sound.save
        @sound = Sound.new
        @sounds = current_user.sounds.order("created_at DESC").page(params[:page]).per(PER_PAGE)
        flash.now[:notice] = "Your sound was saved."
        format.js { render :index }
      else
        @sounds = current_user.sounds.order("created_at DESC").page(params[:page]).per(PER_PAGE)
        flash.now[:alert] = "Your sound could not be saved."
        format.js { render :index }
      end
    end
  end

  def destroy
    @sound = Sound.find(params[:id])
    @sound.destroy
    redirect_to sounds_path, notice: "You've successfully deleted that sound."
  end

private

  def sound_params
    params.require(:sound).permit(:title, :file)
  end

end

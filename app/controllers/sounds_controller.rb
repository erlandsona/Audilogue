class SoundsController < ApplicationController
  before_action :load_sound
  before_action :authenticate_user!

  def index
    @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
    unless current_user == current_user
      @sounds = @sounds.published
    end
  end

  def create
    @sound.author = current_user
    if @sound.save
      message = "Your knowledge has been published."
      @sound.publish!
      redirect_to user_sounds_path(current_user), notice: message
    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end


private


  def load_sound
    if params[:id].present?
      @sound = Sound.find(params[:id])

    else
      @sound = Sound.new
    end

    if params[:sound].present?
      @sound.assign_attributes(sound_params)
    end
  end

  def sound_params
    params.require(:sound).permit(:title, :file)
  end

end

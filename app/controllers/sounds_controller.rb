class SoundsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sound = Sound.new
    @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
  end

#   def create
#     @sound = current_user.sounds.new(sound_params)
#     if @sound.save
#       @sound = Sound.new
#       flash.now[:notice] = "Your sound was saved."
#     else
#       flash.now[:alert] = "Your sound could not be saved."
#     end
#     @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
#     render :index
#     respond_to :js
#   end


  def create
    @sound = current_user.sounds.new(sound_params)
    respond_to do |format|
      if @sound.save
        @sound = Sound.new
        @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
        flash.now[:notice] = "Your sound was saved."
        format.js { render :index }
      else
        @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
        flash.now[:alert] = "Your sound could not be saved."
        format.js { render :index }
      end
    end
  end


private

  def sound_params
    params.require(:sound).permit(:title, :file)
  end

end

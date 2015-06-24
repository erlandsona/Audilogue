class SoundsController < ApplicationController
  before_action :load_sound
  before_action :authenticate_user!
  # before_action :load_user, except: [:new, :create]
  # before_action :require_login

  def index
    @sounds = current_user.sounds.page(params[:page]).per(PER_PAGE)
    unless current_user == current_user
      @sounds = @sounds.published
    end
  end

  def create
    @sound.author = current_user
    if @sound.save
      if params[:commit] == "Save As Draft"
        message = "Your draft has been saved."

      else
        message = "Your knowledge has been published."
        @sound.publish!
      end
      redirect_to user_sounds_path(current_user), notice: message

    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end

  def show
    if @sound.draft? && @sound.author != current_user
      flash.alert = "You do not have permission to access that page."
      redirect_to root_path
    end
    @comments = @sound.comments.all
    @comment = Comment.new
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

  # def load_user
  #   @user = User.find(params[:user_id])
  # end

  def sound_params
    params.require(:sound).permit(:title, :body, :image, :all_tags)
  end

end

class WelcomeController < ApplicationController

  def index
    @users = User.all
    render 'welcome/index'
  end

end

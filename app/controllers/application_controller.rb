class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource)
    sounds_path
  end

end

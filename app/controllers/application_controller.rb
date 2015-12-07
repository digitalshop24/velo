class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_path
  end
end

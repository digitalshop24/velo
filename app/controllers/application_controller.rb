class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_path
  end
  def index
    controller = params[:controller]
    @category = controller.singularize
    model = @category.capitalize.constantize
    instance_variable_set("@#{controller}", nil)
    @products = model.all
    if params[:after]
      after = Date.parse(params[:after])
      @products = @products.where('created_at > ?', after)
    end
    @products = @products.where(display: params[:display]) if params[:display]
    @products = @products.preload(:manufacturer, :gallery).paginate(page: params[:page])
  end
end

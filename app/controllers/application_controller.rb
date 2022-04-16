class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  before_action :search

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  end

  def search
    @q = Room.ransack(params[:q])
  end

end

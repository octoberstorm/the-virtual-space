class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_user_activity

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def update_user_activity
    if !broadcasting_to_current_user?
      current_user.touch(:last_request_at) if user_signed_in?
    end
  end

  def broadcasting_to_current_user?
    params[:from_broadcasting] == "true" && params[:broadcaster] == current_user.id.to_s
  end
end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:root]
    protect_from_forgery with: :exception

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    end
end
  
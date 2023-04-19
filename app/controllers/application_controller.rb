class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:root]
    protect_from_forgery with: :exception
  end
  
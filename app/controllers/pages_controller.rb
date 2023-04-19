class PagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:root]
  def home
    redirect_to articles_path if user_signed_in?
  end

  def index
  end
end

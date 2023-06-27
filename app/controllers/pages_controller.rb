class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :index]

  skip_before_action :authenticate_user!, only: [:root]
  def home
  end

  def index
  end
end

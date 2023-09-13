module Api
  class ArticlesController < ApplicationController
    # before_action :authenticate_user! 
    before_action :authenticate_user!, except: [:show, :index]

    def index
      @articles = Article.all
      render json: @articles
    end    

    def show
      @article = Article.find(params[:id])
      render json: @article
    end

    def filter_by_category
      # Logic to filter blogs by category
      category_id = params[:category_id]
      @articles = Article.where(category_id: category_id)
      render json: @articles
    end

    def filter_by_date
      # Logic to filter blogs by date
      start_date = params[:start_date]
      end_date = params[:end_date]
      @articles = Article.where(created_at: start_date..end_date)
      render json: @articles
    end
  end
end
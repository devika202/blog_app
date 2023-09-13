module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]

    def index
      @articles = Article.all

      @articles = @articles.where(category: params[:category]) if params[:category].present?
      @articles = @articles.where(tags: params[:tags]) if params[:tags].present?
      @articles = @articles.where('like_count >= ?', params[:like_count].to_i) if params[:like_count].present?
    
      if params[:status].present?
        case params[:status].downcase
        when 'pending'
          @articles = @articles.where(status: 'pending')
        when 'declined'
          @articles = @articles.where(status: 'declined')
        when 'approved'
          @articles = @articles.where(status: 'approved')
        else
          render json: { error: 'Invalid status value' }, status: :bad_request
          return
        end
      end

      render json: @articles
    end    

    def show
      @article = Article.find(params[:id])
      render json: @article
    end

    def filter_by_category
      category_id = params[:category_id]
      @articles = Article.where(category_id: category_id)
      render json: @articles
    end

    def filter_by_date
      start_date = params[:start_date]
      end_date = params[:end_date]
      @articles = Article.where(created_at: start_date..end_date)
      render json: @articles
    end
  end
end

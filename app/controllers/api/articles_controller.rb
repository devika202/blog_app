module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index, :filter_config, :tag_suggestions, :status_options]

    def index
      @articles = Article.all
      if params[:tags].present?
        tags = params[:tags].split(',')
        @articles = @articles.where(tags: tags)
      end
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

    def filter_config
      categories = Category.all.pluck(:name) 
      filter_config = { categories: categories }
      render json: filter_config
    end
    
    def tag_suggestions
      tag_suggestions = Article.distinct.pluck(:tags).compact.flatten

      render json: tag_suggestions
    end

    def status_options
      status_options = Article.distinct.pluck(:status)
      render json: status_options
    end
  end
end
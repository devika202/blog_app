module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index, :filter_config, :tag_suggestions, :status_options, :filter_articles]

    def index
      @filters = Filter.all
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

    def filter_articles
      category = params[:category]
      tags = params[:tags].split(',') if params[:tags].present?
      like_count = params[:like_count].to_i if params[:like_count].present?
      status = params[:status].downcase if params[:status].present?
      Rails.logger.info("Category: #{category}")
      Rails.logger.info("Tags: #{tags}")
      Rails.logger.info("Like Count: #{like_count}")
      Rails.logger.info("Status: #{status}")
    
      articles = Article.all

      articles = articles.where(category: category) if category.present?
      articles = articles.where(tags: tags) if tags.present?
      articles = articles.where('like_count >= ?', like_count) if like_count.present?

      if status.present?
        case status
        when 'pending', 'approved', 'declined'
          articles = articles.where(status: status)
        else
          return render json: { error: 'Invalid status value' }, status: :bad_request
        end
      end

      render json: articles
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
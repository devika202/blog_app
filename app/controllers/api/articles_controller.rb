module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index, :filter_config, :tag_suggestions, :status_options, :filter_articles]

    def index
      @filters = Filter.all
      @articles = Article.all
      
      @articles = @articles.where(category: params[:category]) if params[:category].present?
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
      query_params = params[:q]
      
      if query_params.nil? || query_params == "null"
        query_params = {}
      else
        begin
          query_params = JSON.parse(query_params)
        rescue JSON::ParserError => e
          Rails.logger.error("Error parsing query_params JSON: #{e.message}")
          query_params = {}
        end
      end
    
      Rails.logger.info("Fetch Params: #{query_params}")
      category_id_eq = query_params["category_id_eq"]
      created_at_gteq = query_params["created_at_gteq"]
      created_at_lteq = query_params["created_at_lteq"]
      status_eq = query_params["status_eq"]
      tags_eq = query_params["tags_eq"]
      Rails.logger.info("Received filters - Category ID: #{category_id_eq}, Status: #{status_eq}, Created At >=: #{created_at_gteq}, Created At <=: #{created_at_lteq}, tags_eq: #{tags_eq}")
    
      category_name = nil
      articles = Article.all
    
      if category_id_eq.present?
        category = Category.find_by(id: category_id_eq)
        if category.present?
          category_name = category.name
        else
          Rails.logger.warn("Category with ID '#{category_id_eq}' not found")
        end
      end
    
      if category_name.present?
        articles = articles.where(category: category_name)
      end
    
      if status_eq.present?
        articles = articles.where(status: status_eq)
      end
      
      if tags_eq.present?
        articles = articles.where(tags: tags_eq)
      end
    
      if created_at_gteq.present?
        begin
          articles = articles.where("created_at >= ?", Date.parse(created_at_gteq))
        rescue ArgumentError => e
          Rails.logger.error("Error parsing created_at_gteq: #{e.message}")
        end
      end
    
      if created_at_lteq.present?
        begin
          articles = articles.where("created_at <= ?", Date.parse(created_at_lteq))
        rescue ArgumentError => e
          Rails.logger.error("Error parsing created_at_lteq: #{e.message}")
        end
      end
    
      Rails.logger.info("Generated SQL Query: #{articles.to_sql}")
      Rails.logger.info("Filtered articles: #{articles.to_a}")
    
      if articles.empty?
        render json: { message: 'No data found' }, status: :not_found
      else
        render json: articles
      end
    end
    
    def show
      @article = Article.find(params[:id])
      render json: @article
    end
  end
end
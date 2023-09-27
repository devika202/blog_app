class ArticlesController < ApplicationController
    include ArticlesHelper
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
        @article = Article.find(params[:id])
        @comment = Comment.new(article: @article)
        if current_user && current_user.admin?

        else
            if @article.approved?

            else
                redirect_to my_articles_path, alert: "Please wait while the admin approves to view the article."
            end
        end
    end
      
    def index
        @filters = Filter.all
        @tags_suggestions = Article.distinct.pluck(:tags).compact.flatten
        @search = Article.includes(:categories).ransack(params[:q])
        @categories = Category.all
        @q = Article.ransack(params[:q])
        @article = Article.all
        
        if params[:q].present? && (params[:q][:category_id_eq].present? || params[:q][:status_eq].present? || params[:q][:tags_eq].present?)
            category_filter = params[:q][:category_id_eq]
            status_filter = params[:q][:status_eq]
            tags_filter = params[:q][:tags_eq]
            from_date = params[:q][:published_at_gteq]
            to_date = params[:q][:published_at_lteq]
            @articles = @search.result.includes(:categories)
            Rails.logger.debug("Received Tags: #{tags_filter.inspect}")

            if category_filter.present?
                @articles = @articles.joins(:categories).where(categories: { id: category_filter })
            end
        
            if status_filter.present?
                status_filter = Array(status_filter).map(&:to_i)
                @articles = @articles.where(status: status_filter)
            end
        
            if tags_filter.present?
                @articles = @articles.where(tags: tags_filter)
              end
        
            if from_date.present? && to_date.present?
                @articles = @articles.where(published_at: from_date..to_date)
            end
        
            @articles = @articles.paginate(page: params[:page], per_page: 3)
        else
            @articles = @q.result(distinct: true).paginate(page: params[:page], per_page: 3)
        end
        
        article_ids = @articles.pluck(:id)
    end
      
      
    def new
        @article = Article.new
    end

    def edit

    end

    def approve
        @article = Article.find(params[:id])
        @article.update(status: :approved)
        redirect_to @article, notice: 'Article has been approved.'
    end
      
    def decline
        @article = Article.find(params[:id])
        @article.update(status: :declined)
        redirect_to @article, notice: 'Article has been declined.'
    end
      

    def create
        @article = Article.new(article_params)
        @article = current_user.articles.build(article_params)
        @article.image.attach(params[:article][:image])
        @article.status = "pending"
        if @article.save
          
          flash[:notice] = "Article was created successfully."
          redirect_to @article 
        else
            p @article.errors.full_messages
            render :new, status: :unprocessable_entity
        end
    end

    def my_articles
        @articles = current_user.articles
    end
      

    def update
        if params[:article][:image].present?
            @article.image.attach(params[:article][:image])
            @article.image.purge_later 
          end
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully"
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @article.destroy 
        redirect_to articles_path
    end


    private
    

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description,:image,:tags, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end
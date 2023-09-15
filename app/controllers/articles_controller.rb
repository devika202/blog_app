class ArticlesController < ApplicationController
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
        @tags_suggestions = Article.distinct.pluck(:tags).compact
        @search = Article.includes(:categories).ransack(params[:q])
        @articles = @search.result.includes(:categories).paginate(page: params[:page], per_page: 9)
        @categories = Category.all
        @q = Article.ransack(params[:q])
        
        if params[:q] && params[:q][:categories_id_eq_any].present? && (params[:q][:created_at_gteq].present? || params[:q][:created_at_lteq].present?)
          category_filter = params[:q][:categories_id_eq_any]
          from_date = params[:q][:created_at_gteq]
          to_date = params[:q][:created_at_lteq]
    
          articles_by_category = Article.includes(:categories).where(categories: { id: category_filter }).references(:categories)
    
          articles_by_date = Article.where(created_at: from_date..to_date)
    
          @articles = articles_by_category.union(articles_by_date).paginate(page: params[:page], per_page: 3)
        else
          @articles = @q.result(distinct: true).paginate(page: params[:page], per_page: 3)
        end
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
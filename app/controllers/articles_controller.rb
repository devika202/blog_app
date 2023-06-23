class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @article = Article.find(params[:id])
        @comment = Comment.new(article: @article)
    end

    def index
        @search = Article.includes(:categories).ransack(params[:q])
        @articles = @search.result.includes(:categories).paginate(page: params[:page], per_page: 9)
        @categories = Category.all
        @q = Article.ransack(params[:q])
        @articles = @q.result(distinct: true).paginate(page: params[:page], per_page: 3)
    end
      
    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
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
        params.require(:article).permit(:title, :description,:image, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end
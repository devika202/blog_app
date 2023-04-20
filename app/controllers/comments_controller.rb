class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :authenticate_admin!, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?
    
    if @comment.save
      redirect_to @article
    else
      render 'articles/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_back(fallback_location: root_path)
    end
  end
end

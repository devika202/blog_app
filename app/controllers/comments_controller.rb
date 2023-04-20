class CommentsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  
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
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :article_id).tap do |whitelisted|
      whitelisted[:content] = sanitize(params[:comment][:content], tags: %w(strong em b i u p br), attributes: %w())
    end
  end
  
end

class LikesController < ApplicationController
    before_action :authenticate_user!, except: [:create, :destroy]

  def create
    @article = Article.find(params[:article_id])
    unless current_user == @article.author
      like = @article.likes.build(user: current_user)
      if like.save
        redirect_to @article, notice: 'Article liked successfully.'
      else
        redirect_to @article, alert: 'Failed to like the article.'
      end
    else
      redirect_to @article, alert: 'Authors cannot like their own articles.'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    like = @article.likes.find_by(user: current_user)
    if like.present?
      like.destroy
      redirect_to @article, notice: 'Article unliked successfully.'
    else
      redirect_to @article, alert: 'You have not liked the article.'
    end
  end
end

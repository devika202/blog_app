class LikesController < ApplicationController
    before_action :authenticate_user!, except: [:create, :destroy, :create_dislike, :destroy_dislike]

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


  def create_dislike
    @article = Article.find(params[:article_id])
    unless current_user == @article.author
      dislike = @article.dislikes.build(user: current_user)
      if dislike.save
        redirect_to @article, notice: 'Article disliked successfully.'
      else
        redirect_to @article, alert: 'Failed to dislike the article.'
      end
    else
      redirect_to @article, alert: 'Authors cannot dislike their own articles.'
    end
  end

  def destroy_dislike
    @article = Article.find(params[:article_id])
    dislike = @article.dislikes.find_by(user: current_user)
    if dislike.present?
      dislike.destroy
      redirect_to @article, notice: 'Article undisliked successfully.'
    else
      redirect_to @article, alert: 'You have not disliked the article.'
    end
  end
end

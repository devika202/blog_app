class ArticleSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :created_at, :updated_at, :user_id, :status, :tags, :like_count, :dislike_count, :category
  end
  
class AddCountDislikeCountAndCategoryToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :like_count, :integer
    add_column :articles, :dislike_count, :integer
    add_column :articles, :category, :string

    Article.all.each do |article|
      article.update(
        like_count: article.likes.count,
        dislike_count: article.dislikes.count,
        category: article.categories.pluck(:name).join(', ')
      )
    end
  end
end

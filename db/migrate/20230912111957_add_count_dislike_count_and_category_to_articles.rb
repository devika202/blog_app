class AddCountDislikeCountAndCategoryToArticles < ActiveRecord::Migration[5.2]
  def change
    # Add columns to the articles table
    add_column :articles, :count, :integer
    add_column :articles, :dislike_count, :integer
    add_column :articles, :category, :string

    # Populate the new columns with data from corresponding tables
    Article.all.each do |article|
      article.update(
        count: article.likes.count,
        dislike_count: article.dislikes.count,
        category: article.categories.pluck(:name).join(', ')
      )
    end
  end
end

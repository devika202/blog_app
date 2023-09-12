class RemoveLikesCountFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :likes_count, :integer

  end
end

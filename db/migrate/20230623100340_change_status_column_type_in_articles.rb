class ChangeStatusColumnTypeInArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :status, :integer
  end
end

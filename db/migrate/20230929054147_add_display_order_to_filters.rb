class AddDisplayOrderToFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :filters, :display_order, :integer, default: 0
  end
end

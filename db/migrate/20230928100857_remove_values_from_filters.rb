class RemoveValuesFromFilters < ActiveRecord::Migration[5.2]
  def change
    remove_column :filters, :values
  end
end

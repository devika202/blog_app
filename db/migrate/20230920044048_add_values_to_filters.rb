class AddValuesToFilters < ActiveRecord::Migration[5.2]
  def change
    def up
      add_column :filters, :values, :text
  
      Filter.update_all(values: '[]')
  
      change_column_default :filters, :values, nil
      change_column_default :filters, :values, '[]'
    end
  
    def down
      change_column_default :filters, :values, nil
      remove_column :filters, :values
    end  
  end
end

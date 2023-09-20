class PopulateFilters < ActiveRecord::Migration[5.2]
  def change
    category_filter = Filter.create(name: 'Category', column_name: 'category_id', filter_type: 'select')

    category_values = Category.pluck(:name, :id)

    category_filter.update(values: category_values)
    
    Filter.create(name: 'Publication Date', column_name: 'created_at', filter_type: 'date')
  end
end

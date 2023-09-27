class AddTagsFilter < ActiveRecord::Migration[5.2]
  def change
    Filter.create(
      name: 'Tags',
      column_name: 'tags',
      filter_type: 'select',
      values: [] 
    )
  end
end

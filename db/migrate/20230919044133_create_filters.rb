class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.string :name
      t.string :column_name
      t.string :filter_type
    end
  end
end

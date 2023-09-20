class AddStatusToFilters < ActiveRecord::Migration[5.2]
  def change
    status_filter = Filter.create(name: 'Status', column_name: 'status', filter_type: 'select')

    status_values = {
      'Pending' => 0,
      'Approved' => 1,
      'Declined' => 2
    }

    status_filter.update(values: status_values.to_json)
  end
end

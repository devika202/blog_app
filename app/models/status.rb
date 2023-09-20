class Status < ApplicationRecord
    after_create :update_status_filter
  
  
    private
  
    def update_status_filter
      filter = Filter.find_or_create_by(name: 'Status', column_name: 'status', filter_type: 'select')
      filter.update(values: Article.statuses.map { |key, value| [key.humanize, key] })
    end
  end
  
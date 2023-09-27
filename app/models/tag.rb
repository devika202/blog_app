class Tag < ApplicationRecord
    after_create :update_tags_filter
  
    private
  
    def update_tags_filter
      filter = Filter.find_or_create_by(name: 'Tags', column_name: 'tags', filter_type: 'select')
      tags_values = Article.distinct.pluck(:tags).compact.flatten.uniq.map { |tag| [tag, tag] }
      filter.update(values: tags_values.to_json)
    end
  end
  
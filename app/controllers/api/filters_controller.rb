module Api
  class FiltersController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index
      filters = Filter.order(:display_order)
      filter_config = []

      filters.each do |filter|
        if filter.filter_type == 'select'
          filter_config << {
            name: filter.name,
            filter_type: filter.filter_type,
            column_name: filter.column_name,
            values: filter_options(filter.column_name)
          }
        elsif filter.filter_type == 'date'
          filter_config << {
            name: filter.name,
            column_name: filter.column_name,
            filter_type: filter.filter_type
          }
        end
      end

      render json: filter_config
    end

    private

    def filter_options(column_name)
      case column_name
      when 'category_id'
        Category.pluck(:name, :id)
      when 'status'
        Article.statuses.map { |key, value| [key.humanize, value] } 
      when 'tags'           
        Article.distinct.pluck(:tags).compact.flatten.uniq
      else
        []
      end
    end
  end
end
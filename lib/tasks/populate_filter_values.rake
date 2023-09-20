namespace :populate_filter_values do
    desc "Populate Category values in Filter table"
    task populate_categories: :environment do
      categories = Category.pluck(:name, :id)
      category_filter = Filter.find_by(column_name: "category_id")
  
      if category_filter.present?
        category_filter.update(values: categories.to_json)
        puts "Category values updated in Filter table."
      else
        puts "Category filter not found."
      end
    end

    desc "Populate Status values in Filter table"
    task populate_statuses: :environment do
        statuses = Article.statuses.keys.map { |key| [key.humanize, key] }
        status_filter = Filter.find_by(column_name: "status")
    
        if status_filter.present?
        status_filter.update(values: statuses.to_json)
        puts "Status values updated in Filter table."
        else
        puts "Status filter not found."
        end
    end      
  
  end
  
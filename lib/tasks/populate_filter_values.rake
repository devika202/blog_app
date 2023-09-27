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

      desc "Populate Tags values in Filter table"
      task populate_tags: :environment do
        tags_values = Article.distinct.pluck(:tags).compact.flatten.uniq.map(&:to_s)
        tags_filter = Filter.find_by(column_name: "tags")
    
        if tags_filter.present?
          tags_array = tags_values.map { |tag| [tag, tag] }
          tags_filter.update(values: tags_array.to_json)
          puts "Tags values updated in Filter table."
        else
          puts "Tags filter not found."
        end
      end
  end  
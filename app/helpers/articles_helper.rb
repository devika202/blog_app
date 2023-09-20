module ArticlesHelper
  def filter_options(column_name)
    case column_name
    when 'category_id'
      Category.pluck(:name, :id)
    when 'status'
      Article.statuses.map { |key, value| [key.humanize, value] } 
      
    else
      []
    end
  end
end

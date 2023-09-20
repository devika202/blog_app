class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25}
    validates_uniqueness_of :name
    has_many :article_categories
    has_many :articles, through: :article_categories
    after_create :update_category_filter
    private

    def update_category_filter
      filter = Filter.find_or_create_by(name: 'Category', column_name: 'category_id', filter_type: 'select')
      filter.update(values: Category.pluck(:name, :id))
    end
end
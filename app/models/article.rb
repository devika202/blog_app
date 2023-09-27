class Article < ApplicationRecord
    belongs_to :user
    belongs_to :author, class_name: 'User', foreign_key: 'user_id'
    has_many :comments
    has_many :article_categories, dependent: :destroy
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 30000}
    validates :category_ids, presence: true
    has_one_attached :image
    validate :image_presence
    has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    enum status: { pending: 0, approved: 1, declined: 2 }
    after_create :update_tags_filter

    def image_presence
        errors.add(:image, "must be attached") unless image.attached?
    end
    def liked_by?(user)
      if user.present?
        likes.exists?(user_id: user.id)
      else
        false
      end
    end
    def like_count
      likes.count
    end
  
    def dislike_count
      dislikes.count
    end
  
    def category_list
      categories.pluck(:name).join(', ')
    end
    
    after_touch :update_counters
  
    def update_counters
      update(
        like_count: like_count,
        dislike_count: dislike_count,
        category: category_list
      )
    end  
    private
  
    def update_tags_filter
      filter = Filter.find_or_create_by(name: 'Tags', column_name: 'tags', filter_type: 'select')
      tags_values = Article.distinct.pluck(:tags).compact.flatten.uniq.map { |tag| [tag, tag] }
      filter.update(values: tags_values.to_json)
    end
end
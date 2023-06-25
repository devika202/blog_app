class Article < ApplicationRecord
    belongs_to :user
    belongs_to :author, class_name: 'User', foreign_key: 'user_id'
    has_many :comments
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 30000}
    validates :category_ids, presence: true
    has_one_attached :image
    validate :image_presence
    has_many :likes, dependent: :destroy
    enum status: { pending: 0, approved: 1, declined: 2 }
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
    

end
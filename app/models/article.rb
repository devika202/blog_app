class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 30000}
    validates :category_ids, presence: true
    has_one_attached :image
    validate :image_presence
    enum status: { pending: 0, approved: 1, declined: 2 }
    def image_presence
        errors.add(:image, "must be attached") unless image.attached?
      end
end
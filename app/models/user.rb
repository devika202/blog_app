class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  attribute :admin, :boolean, default: false
  validates :name, presence: true
  def has_liked?(article)
    likes.exists?(article: article)
  end
  def has_disliked?(article)
    likes.exists?(article: article)
  end
end

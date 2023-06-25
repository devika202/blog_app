class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  attribute :admin, :boolean, default: false
  validates :name, presence: true
end

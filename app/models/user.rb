class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  mount_uploader :image, ImageUploader

  has_many :tournaments, dependent: :destroy
  has_many :entries
  has_many :entry_tournaments, through: :entries, source: :tournament
  has_many :posts, dependent: :destroy
  has_many :record_posts, through: :posts, source: :tournament
end

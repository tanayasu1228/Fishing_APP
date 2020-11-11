class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  mount_uploader :image, ImageUploader

  has_many :tournaments, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :entry_tournaments, through: :entries, source: :tournament, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :nices
  has_many :comments
end
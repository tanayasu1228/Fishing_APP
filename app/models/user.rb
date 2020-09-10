class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  mount_uploader :image, ImageUploader

  has_many :tournaments
  has_many :entries
  has_many :entry_tournaments, through: :entries, source: :tournament
end

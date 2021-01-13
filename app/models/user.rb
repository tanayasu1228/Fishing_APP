class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  mount_uploader :image, ImageUploader

  has_many :tournaments, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :entry_tournaments, through: :entries, source: :tournament, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :nices
  has_many :comments, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = SecureRandom.urlsafe_base64
    end
  end
end
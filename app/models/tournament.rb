class Tournament < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :fishing_ground, presence: true
  validates :fishing_style, presence: true
  validates :main_rule, presence: true
  validates :fish_name, presence: true
  validates :keeper_size, presence: true
  validates :swap_limit, presence: true
  validates :judging_limit, presence: true
  validates :measure_rule, presence: true

  mount_uploader :image, PictureUploader
  # mount_uploader :image, ImageUploader

  validates_acceptance_of :confirming
  after_validation :check_confirming

  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :posts, dependent: :destroy

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  # トーナメントにエントリーしているか判断するメソッド
  def entry_completed_by?(user)
    entries.where(user_id: user.id).exists?
  end

  # ランキング機能のデータを取得
  def self.sort_rank
    posts = self.includes(:user)
    sort_size_users = posts.group("users.id", "users.nickname").order('sum_catch_size desc').sum(:catch_size)

    result = sort_size_users.map do |k, v|
      user_id = k[0]
      nickname = k[1]
      sum_size = v
      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 投稿した最大サイズの値を取得
      sort_max_size = posts.where(user_id: user_id).group("users.id").maximum(:catch_size)
      max_size = sort_max_size[user_id]
      
      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      # 投稿数を取得
      count = posts.where(user_id: user_id).count(:post_id)

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }
    end
    result
  end
end

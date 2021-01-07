class Tournament < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :fishing_ground, presence: true
  validates :fishing_style, presence: true
  validates :main_rule, presence: true
  validates :fish_name, presence: true
  validates :keeper_size, presence: true
  validates :measure_rule, presence: true

  mount_uploader :image, PictureUploader

  validates_acceptance_of :confirming
  after_validation :check_confirming

  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  def entry_completed_by?(user)
    entries.where(user_id: user.id).exists?
  end

  def self.sort_rank_sumsize(keeper_size, s_limit, j_limit)
    posts = self.includes(:user)
    # ユーザーIDをグループとした投稿時間で並べ替え
    sort_size_users = posts.group("users.id", "users.nickname").maximum(:catch_size)

    result = sort_size_users.map do |k, v|
      user_id = k[0]
      nickname = k[1]
      catch_size = v

      # ユーザーごとに投稿時間で並び替え、入れ替え匹数分の取得
      user_info = posts.where(user_id: user_id).group("users.id", "users.nickname", "posts.created_at").order("posts.created_at ASC").limit(s_limit).maximum(:catch_size)

      array1 = []
      user_info.each do |k, v|
        array1 << v
      end

      keeper_checked_array = []
      array1.each do |n|
        keeper_checked_array << n if keeper_size.to_i <= n
      end
      # 投稿した最大サイズの値を取得
      max_size = keeper_checked_array.max

      array2 = keeper_checked_array.max(j_limit.to_i)

      # 合計値を取得
      sum_size = array2.sum

      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 有効釣果数を取得
      count = posts.where(user_id: user_id).count(:id)

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }

    end
    sort_sumsize = result.sort_by! { |a| a[:sum_size] }
    sort_sumsize.reverse!
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

      # 有効釣果数を取得
      count = keeper_checked_array.count
      # count = posts.where(user_id: user_id).count(:post_id)

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }
    end
    result
  end

  def self.sort_rank_maxsize(keeper_size, s_limit)
    posts = self.includes(:user)
    # ユーザーIDをグループとした投稿時間で並べ替え
    sort_size_users = posts.group("users.id", "users.nickname").maximum(:catch_size)

    result = sort_size_users.map do |k, v|
      user_id = k[0]
      nickname = k[1]
      catch_size = v

      # ユーザーごとに投稿時間で並び替え、入れ替え匹数分の取得
      user_info = posts.where(user_id: user_id).group("users.id", "users.nickname", "posts.created_at").order("posts.created_at ASC").limit(s_limit).maximum(:catch_size)

      # 投稿した最大サイズの値を取得
      array1 = []
      user_info.each do |k, v|
        array1 << v
      end

      keeper_checked_array = []
      array1.each do |n|
        keeper_checked_array << n if keeper_size.to_i <= n
      end

      max_size = keeper_checked_array.max

      # 合計値を取得
      sum_size = keeper_checked_array.sum

      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 有効釣果数を取得
      count = keeper_checked_array.count

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }

    end
    sort_maxsize = result.sort_by! { |a| a[:max_size] }
    sort_maxsize.reverse!
  end

  def self.sort_rank_count(keeper_size)
    posts = self.includes(:user)
    # ユーザーIDをグループとした投稿時間で並べ替え
    sort_size_users = posts.group("users.id", "users.nickname").maximum(:catch_size)

    result = sort_size_users.map do |k, v|
      user_id = k[0]
      nickname = k[1]
      catch_size = v

      # ユーザーごとに投稿時間で並び替え、入れ替え匹数分の取得
      user_info = posts.where(user_id: user_id).group("users.id", "users.nickname", "posts.created_at").order("posts.created_at ASC").maximum(:catch_size)

      # 投稿した最大サイズの値を取得
      array1 = []
      user_info.each do |k, v|
        array1 << v
      end

      keeper_checked_array = []
      array1.each do |n|
        keeper_checked_array << n if keeper_size.to_i <= n
      end

      max_size = keeper_checked_array.max

      # 合計値を取得
      sum_size = keeper_checked_array.sum

      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 有効釣果数を取得
      count = keeper_checked_array.count

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }

    end
    sort_count = result.sort_by! { |a| a[:count] }
    sort_count.reverse!
  end
end


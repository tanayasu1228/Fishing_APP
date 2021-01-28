class Post < ApplicationRecord
  attr_accessor :image_cache
  mount_uploader :fish_image, FishImageUploader

  belongs_to :user
  belongs_to :tournament, optional: true
  has_many :nices
  has_many :comments, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
  is_impressionable

  def niced_by?(user)
    nices.where(user_id: user.id).exists?
  end
    
  # 合計サイズのランキングデータを取得
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
      max_size = keeper_checked_array.max
      array2 = keeper_checked_array.max(j_limit.to_i)
      sum_size = array2.sum
      image = posts.where(user_id: user_id).first.user.image.url
      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url
      count = keeper_checked_array.count
      post_id = posts.where(user_id: user_id).pluck("posts.id")

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count, post_id: post_id }

    end
    sort_sumsize = result.sort_by! { |a| -a[:sum_size] }
  end

  # 最大サイズでのランキングデータを取得
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

      array1 = []
      user_info.each do |k, v|
        array1 << v
      end

      keeper_checked_array = []
      array1.each do |n|
        keeper_checked_array << n if keeper_size.to_i <= n
      end

      max_size = keeper_checked_array.max
      sum_size = keeper_checked_array.sum
      image = posts.where(user_id: user_id).first.user.image.url
      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url
      count = keeper_checked_array.count
      post_id = posts.where(user_id: user_id).pluck("posts.id")

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count, post_id: post_id }

    end
    sort_maxsize = result.sort_by! { |a| -a[:max_size] }
  end

  # 釣果数でのランキングデータを取得
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

      array1 = []
      user_info.each do |k, v|
        array1 << v
      end

      keeper_checked_array = []
      array1.each do |n|
        keeper_checked_array << n if keeper_size.to_i <= n
      end

      max_size = keeper_checked_array.max
      sum_size = keeper_checked_array.sum
      image = posts.where(user_id: user_id).first.user.image.url
      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url
      count = keeper_checked_array.count
      post_id = posts.where(user_id: user_id).pluck("posts.id")

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count, post_id: post_id }

    end
    sort_count = result.sort_by! { |a| -a[:count] }
  end
end

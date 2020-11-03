class Post < ApplicationRecord
  mount_uploader :fish_image, FishImageUploader

  belongs_to :user
  belongs_to :tournament, optional: true
  # belongs_to :entry

  # geocoder.rbにて緯度、経度のカラムに対して自動的に値を入れる為に必要
  # geocoded_by :address
  # after_validation :geocode, if: :address_changed?

# 逆ジオコーディング 緯度、経度から住所を取得
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
  # PV数の計測
  is_impressionable

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

      image = posts.where(user_id: user_id).first.user.image.url
      post_id = posts.where(user_id: user_id).pluck("posts.id")

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, post_id: post_id }
    end
    result
  end
end

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
  # mount_uploader :image, ImageUploader

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

  # トーナメントにエントリーしているか判断するメソッド
  def entry_completed_by?(user)
    entries.where(user_id: user.id).exists?
  end

  # メインルールに対して入れ替え枠の有無を判断するメソッド
  def swap_limit_ture?(user)
    entries.where(user_id: user.id).exists?
  end

  # メインルールに対して合計値枠の有無を判断するメソッド
  def judging_limit_ture?(user)
    entries.where(user_id: user.id).exists?
  end

  # メインルールに対して入れ替え枠の有無を判断するメソッド
  # def swap_limit(user)
  #   entries.where(user_id: user.id).exists?
  # end





  def swap_narrow_down(s_limit)
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
      max_size = array1.max

      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      # 総投稿数を取得
      count = posts.where(user_id: user_id).count(:post_id)

      { nickname: nickname, max_size: max_size, sum_size: sum_size, max_size_image: max_size_image, image: image, count: count }
    end
    result
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

  def self.sort_rank_maxsize(s_limit)
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
      max_size = array1.max

      # 合計値を取得
      sum_size = array1.sum

      # 投稿ユーザーimageを取得
      image = posts.where(user_id: user_id).first.user.image.url

      max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

      # 総投稿数を取得
      # count = posts.where(user_id: user_id).count(:post_id)

      { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size}

    end
    sort_maxsize = result.sort_by! { |a| a[:max_size] }
    sort_maxsize.reverse!
  end

  # def self.sort_rank
  #   posts = self.includes(:user)
  #   sort_size_users = posts.group("users.id", "users.nickname").order('sum_catch_size desc').sum(:catch_size)

  #   result = sort_size_users.map do |k, v|
  #     user_id = k[0]
  #     nickname = k[1]
  #     sum_size = v
  #     max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

  #     # 投稿した最大サイズの値を取得
  #     sort_max_size = posts.where(user_id: user_id).group("users.id").maximum(:catch_size)
  #     max_size = sort_max_size[user_id]
      
  #     # 投稿ユーザーimageを取得
  #     image = posts.where(user_id: user_id).first.user.image.url

  #     # 投稿数を取得
  #     count = posts.where(user_id: user_id).count(:post_id)

  #     { nickname: nickname, image: image, sum_size: sum_size, max_size_image: max_size_image, max_size: max_size, count: count }
  #   end
  #   result
  # end



#   def self.sort_rank_maxsize(s_limit)
# @maxsize_ranks = @tournament.posts.includes(:user)

#       # OK
#       sort_size_users = @maxsize_ranks.group("users.id", "users.nickname").maximum(:catch_size)

#       # ?
#       # sort_size_users = @maxsize_ranks.group("users.id", "posts.created_at").order("posts.created_at ASC").maximum(:catch_size)

#       user_base = sort_size_users.map do |k, v|
#         user_id = k[0]
#         # created_at = k[1]
#         # nickname = k[1]
#         # catch_size = v

#         # ユーザー別の投稿サイズの値を取得  OK
#         user_info = @maxsize_ranks.where(user_id: user_id).group("users.id", "users.nickname", "posts.created_at").order("posts.created_at ASC").limit(s_limit).maximum(:catch_size)

#         # ?
#         # user_info = sort_size_users.where(user_id: user_id).group("users.id").order('maximum_catch_size desc').limit(s_limit).maximum(:catch_size)

#         # user_id = k[0]
#         # created_at = k[1]

#         # sort_max_size = user_info.where(user_id: user_id).group("users.id").maximum(:catch_size)
#         #   max_size = sort_max_size[user_id]


#         # sort_max_size = user_info.where(user_id: user_id).group("users.id").maximum(:catch_size)
#         #   max_size = sort_max_size[user_id]
#         { user_id: user_id }

#         sort_max_size = user_info.map do |k,v|
#           user_id = k[0]
#           created_at = k[1]
#           catch_size = v

#           max_size = @maxsize_ranks.where(user_id: user_id).group("users.id", "users.nickname").order("posts.catch_size DESC").maximum(:catch_size)
#         end
#       end

      
#       sort_max_size = user_base.map do |k,v|
#         user_id = k[0]
#         created_at = k[1]
#         catch_size = v

#         max_size = @maxsize_ranks.where(user_id: user_id).group("users.id", "users.nickname").order("posts.catch_size DESC").maximum(:catch_size)
#       end





    # posts = self.includes(:user)

    # user_posts_info = posts.group("users.id").order('posts.created_at asc')

    # sort_size_users = user_posts_info.group("users.id", "posts.created_at", "users.nickname").maximum(:catch_size)

    # result = sort_size_users.map do |k, v|
    #   user_id = k[0]
    #   created_at = k[1]
    #   nickname = k[2]
    #   max_size = v
    #   max_size_image = posts.where(user_id: user_id).order(catch_size: "DESC").first.fish_image.url

    #   # 投稿した最大サイズの値を取得
    #   sort_max_size = posts.where(user_id: user_id).group("users.id").maximum(:catch_size)
    #   max_size = sort_max_size[user_id]
      
    #   # 投稿ユーザーimageを取得
    #   image = posts.where(user_id: user_id).first.user.image.url

    #   # 投稿数を取得
    #   count = posts.where(user_id: user_id).count(:post_id)

    #   { nickname: nickname, image: image, max_size_image: max_size_image, max_size: max_size, count: count }
    # end
    # result
  # end


  

  
end


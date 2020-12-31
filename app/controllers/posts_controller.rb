class PostsController < ApplicationController
  impressionist :actions=> [:show]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def confirm
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @user = @post.user
    img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image.url}")

    # 緯度：10進数に変換
    exif_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(',').map(&:strip)
    @post.latitude = (Rational(exif_lat[0]) + Rational(exif_lat[1])/60 + Rational(exif_lat[2])/3600).to_f

    # 経度：10進数に変換
    exif_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(',').map(&:strip)
    @post.longitude = (Rational(exif_lng[0]) + Rational(exif_lng[1])/60 + Rational(exif_lng[2])/3600).to_f

    dt = img.get_exif_by_entry('DateTimeOriginal')
    @post.datetime = Time.strptime(dt[0][1], '%Y:%m:%d %H:%M:%S')
    # binding.pry
    return if @post.valid?
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    # img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image.url}")
    # @post.datetime = img.get_exif_by_entry('DateTimeOriginal')[0][1]
    @post.save!
    redirect_to tournament_path(@tournament)
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
    @comment_reply = @post.comments.build
    @user = @post.user
    img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image.url}")

    # 緯度取得：10進数に変換
    exif_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(',').map(&:strip)
    @latitude = (Rational(exif_lat[0]) + Rational(exif_lat[1])/60 + Rational(exif_lat[2])/3600).to_f

    # 経度取得：10進数に変換
    exif_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(',').map(&:strip)
    @longitude = (Rational(exif_lng[0]) + Rational(exif_lng[1])/60 + Rational(exif_lng[2])/3600).to_f

    # address = @post.address.split(",")
    # @address = address[1]
    # binding.pry

    dt = img.get_exif_by_entry('DateTimeOriginal')
    @post.datetime = Time.strptime(dt[0][1], '%Y:%m:%d %H:%M:%S')
# binding.pry
    impressionist(@post, nil, unique: [:session_hash])
  end

  def record
    @post = Post.find(params[:id])
    @user = @post.user
    @tournament = @post.tournament
    @posts = @user.posts & @tournament.posts
  end

  def ranks
    @tournament = Tournament.find(params[:tournament_id])

    keeper_size = @tournament.keeper_size
    s_limit = @tournament.swap_limit
    j_limit = @tournament.judging_limit
    main_rule = @tournament.main_rule

    if main_rule == "合計長さで勝負"
      @ranks = @tournament.posts.sort_rank_sumsize(keeper_size, s_limit, j_limit)
    elsif main_rule == "デカイもん勝ち"
      @ranks = @tournament.posts.sort_rank_maxsize(keeper_size, s_limit)
    elsif main_rule == "とにかく数を釣れ"
      @ranks = @tournament.posts.sort_rank_count(keeper_size)
    else
    end
  end


  private

  def post_params
    params.require(:post).permit(:fish_image, :fish_image_cache, :address, :latitude, :longitude, :fish_name, :catch_size, :weight, :lure, :rod, :reel,:line, :range, :datetime).merge(tournament_id: params[:tournament_id])
  end
end
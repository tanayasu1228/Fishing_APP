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
    @post.save!
    redirect_to tournament_path(@tournament)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image.url}")

    # 緯度：10進数に変換
    exif_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(',').map(&:strip)
    @latitude = (Rational(exif_lat[0]) + Rational(exif_lat[1])/60 + Rational(exif_lat[2])/3600).to_f

    # 経度：10進数に変換
    exif_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(',').map(&:strip)
    @longitude = (Rational(exif_lng[0]) + Rational(exif_lng[1])/60 + Rational(exif_lng[2])/3600).to_f

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
    @ranks = @tournament.posts.sort_rank
  end


  private

  def post_params
    params.require(:post).permit(:fish_image, :fish_image_cache, :address, :latitude, :longitude, :fish_name, :catch_size, :weight, :lure, :rod, :reel,:line, :range).merge(tournament_id: params[:tournament_id])
  end
end
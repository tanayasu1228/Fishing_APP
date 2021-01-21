class PostsController < ApplicationController
  attr_accessor :latitude, :longitude, :datetime
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
    # if !@post.fish_image.present?
    #   @post.fish_image.retrieve_from_cache! @post.fish_image_cache
    # end
    # @post.fish_image_cache = @post.fish_image_will_change!


    # require 'exifr/jpeg'
    # img = Magick::ImageList.new("#{@post.fish_image}")
    # obj = FishImageUploader.new
    # binding.pry
    # @latitude = EXIFR::JPEG::new("s3://fishingapp-angler-s3-bucket/#{@post.fish_image.path}").gps.latitude

    # @latitude = @post.fish_image.latitude
     @post.latitude = @post.fish_image.latitude
     @post.longitude = @post.fish_image.longitude
     @post.datetime = @post.fish_image.datetime

    #  @post.save!
    #  @post.datetime = Time.strptime(@post.fish_image.datetime, '%Y:%m:%d %H:%M:%S')

    # img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image}")
    # img = Magick::Image.read("#{@post.fish_image}")
    # img = Magick::Image.read("#{@post.fish_image}")
    # image = img.to_s
    # img = image.split("=>")
    # image = img[0]
    # img = image.split("[")
    # image = img[1]

# binding.pry
#     get_exif = img.get_exif_by_entry('GPSLatitude')
#     if get_exif[0][1].nil?
#       redirect_to new_tournament_post_path(@tournament), alert: "写真にGPSデータが無いため、投稿出来ませんでした。"
#     else
#       exif_lat = Post.get_exif_latitude(img)
#       @latitude = Post.get_exif_gps(exif_lat)

#       exif_lng = Post.get_exif_longitude(img)
#       @longitude =  Post.get_exif_gps(exif_lng)

#       dt = img.get_exif_by_entry('DateTimeOriginal')
#       @post.datetime = Time.strptime(dt[0][1], '%Y:%m:%d %H:%M:%S')

      return if @post.valid?
    # end
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    # binding.pry
    # @post.latitude = @latitude
    # @post.longitude = @post.fish_image.longitude
    # @post.datetime = @post.fish_image.datetime
    # binding.pry
    @post.save!
    # binding.pry
    redirect_to tournament_path(@tournament)
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
    @comment_reply = @post.comments.build
    @user = @post.user

    @latitude = @post.fish_image.latitude
    @longitude = @post.fish_image.longitude
    @post.datetime = @post.fish_image.datetime
    # @post.datetime = Time.strptime(@post.fish_image.datetime, '%Y:%m:%d %H:%M:%S')


    # img = Magick::ImageList.new("#{@post.fish_image}")
    # # img = Magick::ImageList.new(Rails.root.to_s + "/public#{@post.fish_image.url}")

    # exif_lat = Post.get_exif_latitude(img)
    # @latitude = Post.get_exif_gps(exif_lat)

    # exif_lng = Post.get_exif_longitude(img)
    # @longitude =  Post.get_exif_gps(exif_lng)

    # dt = img.get_exif_by_entry('DateTimeOriginal')
    # @post.datetime = Time.strptime(dt[0][1], '%Y:%m:%d %H:%M:%S')

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
    params.require(:post).permit(:fish_image, :fish_image_cache, :address, :latitude, :longitude, :fish_name, :catch_size, :weight, :lure, :rod, :reel,:line, :range, :datetime, :comment).merge(tournament_id: params[:tournament_id])
  end
end
class PostsController < ApplicationController
  attr_accessor :latitude, :longitude, :datetime
  impressionist :actions=> [:show]
  def index
    @posts = Post.all
  end

  def new
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.new
  end

  def confirm
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @user = @post.user
    if @post.fish_image.latitude.nil? || @post.fish_image.longitude.nil?
      redirect_to new_tournament_post_path, alert: "GPSデータがありません。カメラの位置情報設定を変更してください"
    else
      @post.latitude = @post.fish_image.latitude
      @post.longitude = @post.fish_image.longitude
      @post.datetime = @post.fish_image.datetime
      return if @post.valid?
    end
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
    redirect_to tournament_path(@tournament), notice: "投稿が完了しました" 
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
    @comment_reply = @post.comments.build
    @user = @post.user
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
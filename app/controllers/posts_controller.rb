class PostsController < ApplicationController

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
    @post.save!
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
  end

  def record
    @post = Post.find(params[:id])
    @user = @post.user
    @tournament = @post.tournament
    @posts = @user.posts & @tournament.posts
  end

  def ranks
    @tournament = Tournament.find(params[:tournament_id])
    @ranks = @tournament.posts.joins(:user).group("users.id", "users.nickname").order('sum_catch_size desc').sum(:catch_size)
    @max_size_img = @tournament.posts.joins(:user).group("users.id").maximum(:catch_size)
  end


  private

  def post_params
    params.require(:post).permit(:fish_image, :fish_name, :catch_size, :weight, :lure, :rod, :reel,:line, :range).merge(tournament_id: params[:tournament_id])
  end
end
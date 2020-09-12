class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
    return if @post.valid?
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to posts_path notice: 'トーナメントに釣果を投稿しました。' 
  end

  def show
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:fish_image, :fish_name, :catch_size, :weight, :lure, :rod, :reel,:line, :range)
  end
end
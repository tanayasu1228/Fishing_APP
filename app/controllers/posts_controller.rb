class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def cretae
    @post = Post.new(post_params)
    @post.user_id = current_user.id
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
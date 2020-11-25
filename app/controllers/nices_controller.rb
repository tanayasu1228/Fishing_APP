class NicesController < ApplicationController
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:post_id])
    @nice = current_user.nices.build(post_id: params[:post_id])
    @nice.save!
  end

  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:post_id])
    @nice = Nice.find_by(user_id: current_user.id)
    @nice.destroy
  end
end



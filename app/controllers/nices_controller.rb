class NicesController < ApplicationController
  def create
    @nice = current_user.nices.build(post_id: params[:post_id])
    @nice.save
    redirect_to tournament_post_path(tournament_id: params[:tournament_id], id: params[:post_id])
  end

  def destroy
    @nice = Nice.find_by(user_id: current_user.id)
    @nice.destroy
    redirect_to tournament_post_path(tournament_id: params[:tournament_id], id: params[:post_id])
  end
end



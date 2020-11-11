class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to tournament_post_path(tournament_id: params[:tournament_id], id: params[:post_id])
    else
      render "posts/show"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to tournament_post_path(tournament_id: params[:tournament_id], id: params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    
  end
end



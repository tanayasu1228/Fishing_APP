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
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    
  end
end



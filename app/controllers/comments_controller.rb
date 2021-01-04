class CommentsController < ApplicationController
  before_action :set_comment_instances
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save!
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id], tournament_id: params[:tournament_id])
  end

  def set_comment_instances
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments
    @comment_reply = @post.comments.build
  end
end
class CommentsController < ApplicationController
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment_reply = @post.comments.build
    @comment.save!
  end

  def destroy
    
    Comment.find(params[:id]).destroy
    
    # @comment = Comment.find(params[:id])
    # @comment.destroy

    # @comment_reply = Comment.find(params[:id])
    # @comment_reply.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id], tournament_id: params[:tournament_id])
  end
end



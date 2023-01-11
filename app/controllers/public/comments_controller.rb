class Public::CommentsController < ApplicationController
  
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    @comment = Comment.new
  end

  def destroy
    Comment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

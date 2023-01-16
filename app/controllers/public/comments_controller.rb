class Public::CommentsController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @post.create_notification_comment!(current_customer, @comment.id)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy if @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end


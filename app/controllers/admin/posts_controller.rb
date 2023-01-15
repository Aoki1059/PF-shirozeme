class Admin::PostsController < ApplicationController
before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.where(is_deleted: false)
    @posts = Post.all.page(params[:page]).per(9)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path(@post)
  end

  private
  def post_params
    params.require(:post).permit(:castle, :image, :body)
  end
end

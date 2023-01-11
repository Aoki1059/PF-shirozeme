class Public::PostsController < ApplicationController
  def show
  end

  def index
    @posts = Post.all
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が完了しました！"
    else
      @posts = Post.all
      render 'index'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集が完了しました！"
    else
      render "edit"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:castle, :image, :body)
  end
end

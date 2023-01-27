class Public::PostsController < ApplicationController
  
  before_action :authenticate_customer!, only: [:create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @post_new = Post.new
    @comment = Comment.new
    @customer = current_customer
    @comments = @post.comments.order('created_at DESC').page(params[:page]).per(12)
  end

  def index
    @posts = Post.published.order('created_at DESC').page(params[:page]).per(6)
    @post = Post.new
    @customer = current_customer
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
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
    params.require(:post).permit(:castle, :image, :body, :is_published_flag)
  end
end

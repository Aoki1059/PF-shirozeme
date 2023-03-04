class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:index, :create, :destroy]

  def index
    @bookmarks = Bookmark.where(customer_id: current_customer.id).page(params[:page]).per(6)
  end

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(customer_id: current_customer.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(customer_id: current_customer.id)
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end

  private
  def ensure_guest_customer
    @customer = current_customer
    if @customer.name == "ゲスト"
      redirect_to customer_path(current_customer)
    end
  end
end

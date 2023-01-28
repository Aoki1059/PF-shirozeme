class Public::BookmarksController < ApplicationController
before_action :authenticate_customer!

  def index
    @customer = current_customer
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
end

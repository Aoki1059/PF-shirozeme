class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(params[:customer_id])
    @customer.create_notification_follow!(current_customer)
    redirect_to request.referer
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.page(params[:page]).per(5)
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.page(params[:page]).per(5)
  end
end

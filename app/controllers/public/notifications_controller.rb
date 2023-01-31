class Public::NotificationsController < ApplicationController
  before_action :ensure_guest_customer, only: [:index, :destroy_all]

  def index
    @notifications = current_customer.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to notifications_path
  end

  private
  def ensure_guest_customer
    @customer = current_customer
    if @customer.name == "ゲスト"
      redirect_to customer_path(current_customer)
    end
  end
end

class Admin::CustomersController < ApplicationController
before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(5)
  end

  def index
    @customers = Customer.where(is_deleted: false)
    @customers = @customers.page(params[:page]).per(5)
  end

  def withdraw
    @customer = Customer.find(params[:format])
    @customer.update(is_deleted: true)
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_customers_path(@customer)
  end

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end

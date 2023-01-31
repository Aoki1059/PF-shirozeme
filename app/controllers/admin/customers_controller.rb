class Admin::CustomersController < ApplicationController
before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(5)
  end

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end

class Admin::CustomersController < ApplicationController
before_action :authenticate_admin!
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @posts = @customer.posts.page(params[:page]).per(10)
  end

  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  def withdraw
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_customer_path(@customer)
  end
  
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end

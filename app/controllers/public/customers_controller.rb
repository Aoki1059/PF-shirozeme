class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  before_action :ensure_guest_customer, only: [:edit, :update, :unsubscribe, :withdraw]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order('created_at DESC').page(params[:page]).per(6)
    @post = Post.new
  end

  def index
    @post = Post.new
    @posts = Post.all
    @customers = Customer.where(is_deleted: false).page(params[:page]).per(5)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "登録情報を変更しました"
       redirect_to customers_path
    else
       render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.destroy
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

  def ensure_guest_customer
    @customer = current_customer
    if @customer.name == "ゲスト"
      redirect_to customer_path(current_customer)
    end
  end
end

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
    @post = Post.all
  end

  def index
    @customers = Customer.all.page(params[:page]).per(5)
    @post = Post.new
    @posts = Post.all
    @customers = Customer.where(is_deleted: false)
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
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "ゲスト"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end

class Public::CustomersController < ApplicationController
  
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
    @customer = current_customer
  end

  def index
    @customers = customer.all
    @post = Post.new
    @posts = Post.all
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(:params[:id])
    @customer = current_customer
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
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end

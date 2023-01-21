class Public::SearchesController < ApplicationController
before_action :authenticate_customer!

  def search
    @customer = current_customer
    @text = params[:word]
    @range = params[:range]
    if @range == "会員名"
      @customers = Customer.looks(params[:search], params[:word]).page(params[:page]).per(5)
      # @customers = Customer.page(params[:page]).per(5)
    else
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(5)
    end
  end
end

class Public::SearchesController < ApplicationController
before_action :authenticate_customer!

  def search
    @customer = current_customer
    @text = params[:word]
    @range = params[:range]
    if @range == "会員名"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end

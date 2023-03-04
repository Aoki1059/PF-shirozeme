class Public::SearchesController < ApplicationController
before_action :authenticate_customer!

  def search
    @text = params[:word]
    @range = params[:range]
    if @range == "会員名"
      @customers = Customer.looks(params[:search], params[:word]).page(params[:page]).per(5)
    else
      @posts = Post.published.looks(params[:search], params[:word]).page(params[:page]).per(5)
    end
  end
end

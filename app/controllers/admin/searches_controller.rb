class Admin::SearchesController < ApplicationController
before_action :authenticate_admin!

  def search
    @text = params[:word]
    @range = params[:range]
    if @range == "会員名"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end

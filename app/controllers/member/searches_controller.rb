class Member::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @search = params[:word]
    if user_signed_in?
      if @range == "User"
        @users = User.valid_looks(params[:search],params[:word])
        
      elsif @range =="Post"
        @posts = Post.valid_looks(params[:search],params[:word])
      end
    elsif admin_signed_in?
      if @range == "User"
        @users = User.looks(params[:search],params[:word])
      elsif @range =="Post"
        @posts = Post.looks(params[:search],params[:word])
      end
    end
  end
end

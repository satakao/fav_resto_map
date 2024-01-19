class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @search = params[:word]
    if @range == 'User'
      @users = User.looks(params[:search], params[:word])
    elsif @range == 'Post'
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end

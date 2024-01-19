class Admin::SearchesController < ApplicationController
  def search
    @search = params[:word]
    @results = User.looks(params[:word]) + Post.looks(params[:word])
    # if @range == 'User'
    #   @users = User.looks(params[:search], params[:word])
    # elsif @range == 'Post'
    #   @posts = Post.looks(params[:search], params[:word])
    # end
  end
end

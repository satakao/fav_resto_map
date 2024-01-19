class Member::SearchesController < ApplicationController
  def search
    @search = params[:word]
    if user_signed_in?
      @results = User.valid_looks(params[:word]) + Post.valid_looks(params[:word])
    # @users = User.valid_looks(params[:search],params[:word])
    # @posts = Post.valid_looks(params[:search],params[:word])

    elsif admin_signed_in?
      @results = User.looks(params[:word]) + Post.looks(params[:word])
      # @users = User.looks(params[:search],params[:word])
      # @posts = Post.looks(params[:search],params[:word])
    end
  end
end

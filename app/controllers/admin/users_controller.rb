class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def activate
    @user = User.find(params[:user_id])
    @user.update(is_active: true)
    redirect_to request.referer, notice: 'User activated successfully.'
  end

  def deactivate
    @user = User.find(params[:user_id])
    @user.update(is_active: false)
    redirect_to request.referer, notice: 'User deactivated successfully.'
  end
end

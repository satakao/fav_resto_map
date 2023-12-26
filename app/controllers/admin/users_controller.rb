class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
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
    redirect_to request.referer, notice: 'ユーザーステータスを利用可に変更しました'
  end

  def deactivate
    @user = User.find(params[:user_id])
    @user.update(is_active: false)
    redirect_to request.referer, notice: 'ユーザーステータスを利用不可に変更しました.'
  end
end

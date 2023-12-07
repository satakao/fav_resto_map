class Member::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @post = Post.new
  end

  def mypage
    @user = current_user
    @post = Post.new
  end

  def edit
  end


  def update
  end

  def confirm
  end

  def destroy
  end

end

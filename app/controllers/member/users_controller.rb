class Member::UsersController < ApplicationController
  def show
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

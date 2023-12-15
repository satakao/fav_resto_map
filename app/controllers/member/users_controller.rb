class Member::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy, ]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @post = Post.new
    @bookmarked_posts = Post.bookmarked_posts(current_user)
  end

  def mypage
    @user = current_user
    @post = Post.new
    @posts = current_user.bookmarks.includes(:post).map(&:post)
    @latlngs = []
    # 投稿住所から変換して緯度と経度に変換、格納する
    @posts.each do |post|
      # 緯度経度を配列にして代入
       coordinates = [post.latitude,post.longitude]
      # 緯度経度を順次追加
        @latlngs << coordinates

    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to posts_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user),notice: "ユーザー情報を更新しました。"
    else
    render :edit
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    redirect_to root_path,notice: "アカウント削除が完了しました。"
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end

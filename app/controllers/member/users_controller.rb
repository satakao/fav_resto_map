class Member::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: %i[edit update destroy]

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @publish_posts = Post.includes(:user).where(users: { id: @user.id }).where(posts: { is_published: true })
    @private_posts = Post.includes(:user).where(users: { id: @user.id }).where(posts: { is_published: false })
    @bookmarked_posts = Post.bookmarked_post(@user)
    @bookmarked_posts_private = Post.bookmarked_post(@user).includes(:user).where(posts: { is_published: true })
  end

  def mypage
    @user = current_user
    @post = Post.new
    @tags = @post.tags.pluck(:name).join(', ')
    posts = current_user.bookmarked_posts
    @latlngs = latlngs(posts)
    # 投稿住所から変換して緯度と経度に変換、格納する
  end

  def index
    @users = User.where(users: { is_active: true })
  end

  def edit
    @user = User.find(params[:id])
    return unless @user != current_user

    redirect_to posts_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    redirect_to root_path, notice: 'アカウント削除が完了しました。'
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
    return unless @user.guest_user?

    redirect_to user_path(current_user), notice: '他のユーザー編集画面への遷移、またはゲストユーザーはプロフィール編集画面へ遷移できません。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def latlngs(posts)
    arr = []
    posts.each do |post|
      # 緯度経度を配列にして代入
      coordinates = [post.latitude, post.longitude]
      # 緯度経度を順次追加
      arr << coordinates
    end
    arr
  end
end

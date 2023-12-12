class Member::UsersController < ApplicationController
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
      results = Geocoder.search(post.address)
      if results.present?
        @latlngs << results.first.coordinates
      end
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
      redirect_to user_path(@user),notice: "You have updated user successfully."
    else
    render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end

class Member::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    # 利用有効になっているユーザーで、そのユーザーの投稿で表示にしている投稿一覧を表示
    @posts = Post.includes(:user).where(users: { is_active: true }).where(is_published: true)


  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def destroy

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を編集しました"
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    results = Geocoder.search(post_params[:address])

    if results.present?
      coordinates = results.first.coordinates
      @post.latitude = coordinates[0]
      @post.longitude = coordinates[1]
    end

    if @post.save
      @posts = Post.all
      redirect_to posts_path
    else
      @user =current_user
      render "member/users/mypage"
    end
  end

  def search
     posts = Post.where(latitude: params[:lat]).where(longitude: params[:lng])
    @marker_arr =[]
    posts.each do |post|
            #pushメソッドは配列に値を入れるメソッド
      @marker_arr.push(post)
    end
  end


  private
  def post_params
    params.require(:post).permit(:store_name, :address, :description, :is_published, :image)
  end
end

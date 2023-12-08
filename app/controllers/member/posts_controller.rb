class Member::PostsController < ApplicationController
  def index
    @posts = Post.all
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
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      @posts = Post.all
      redirect_to posts_path
    else
      @user =current_user
      render "member/users/mypage"
    end
  end

  private
  def post_params
    params.require(:post).permit(:store_name, :description, :is_published, :image)
  end
end

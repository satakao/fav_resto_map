class Member::PostsController < ApplicationController
  def index
  end

  def show
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @posts = Post.all
    else
      render mypage
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:store_name, :description, :is_published)
  end
end

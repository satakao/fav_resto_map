class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comments = @post.post_comments
    # @post_comments = Post.includes(:post_comments).all
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to admin_path, notice: '投稿を削除しました'
  end
end

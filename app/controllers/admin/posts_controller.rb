class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comments = @post.post_comments
    # @post_comments = Post.includes(:post_comments).all

  end
end

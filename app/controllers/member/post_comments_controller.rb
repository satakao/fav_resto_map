class Member::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save

    else
      @user = @post.user
      render 'error', status: :unprocessable_entity
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.find_by(post_id: @post.id)
    @post_comment = PostComment.find(params[:id]).destroy

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end

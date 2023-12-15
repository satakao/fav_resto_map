class Member::BookmarksController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: @post.id)
    bookmark.save

  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy
    # redirect_to request.referer
  end
end

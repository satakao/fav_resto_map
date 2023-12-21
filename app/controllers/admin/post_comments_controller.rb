class Admin::PostCommentsController < ApplicationController
  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    redirect_to request.referer,notice:"コメントを削除しました"
  end
end

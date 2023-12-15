class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @posts = Post.all
  end
end

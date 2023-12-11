class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @search = params[:word]
    if @range == "User"
      @users = User.looks(params[:search],params[:word])
    end
  end
end

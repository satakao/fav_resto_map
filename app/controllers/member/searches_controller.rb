class Member::SearchesController < ApplicationController
  def search
    @search = params[:word]

    if user_signed_in?

      @results = User.valid_looks(params[:word]) + Post.valid_looks(params[:word])

    elsif admin_signed_in?

      @results = User.looks(params[:word]) + Post.looks(params[:word])

    end
  end
end

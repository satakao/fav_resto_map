class Member::HomesController < ApplicationController
  # ログアウトしていない場合に実行
  before_action :ensure_not_logged_in
  def top; end

  private

  def ensure_not_logged_in
    if user_signed_in?
      redirect_to users_mypage_path, notice: 'ホーム/ログイン画面に行くにはログアウトを行ってください'
    elsif admin_signed_in?
      redirect_to admin_path, notice: 'ホーム/ログイン画面に行くにはログアウトを行ってください'
    end
  end
end

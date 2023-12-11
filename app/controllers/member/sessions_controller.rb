# frozen_string_literal: true

class Member::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to users_mypage_path, notice: "guestuserでログインしました。"
  end

  def after_sign_in_path_for(resource)
    users_mypage_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def user_state
    user = User.find_by(email: params[:user][:email])
    # もしuserの中にemailが一致するデータが無ければこの処理を終了する
    return if user.nil?
    # emailの一致するuserに対してパスワードが一致しない場合この処理を終了する
    return unless user.valid_password?(params[:user][:password])
    return if user.is_active
    flash[:error] = "制限がかけられているためこのアカウントは使用できません。"
    redirect_to new_user_session_path
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

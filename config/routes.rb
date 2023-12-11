Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #使用するコントローラ指定、不要なパスワード変更のルーティング削除
  devise_for :users,skip: [:passwords],controllers: {
  registrations: "member/registrations",
  sessions: "member/sessions"
  }
  #使用するコントローラ指定、不要なパスワード変更と管理者登録のルーティング削除
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_scope :user do
    post "member/guest_sign_in", to: "member/sessions#guest_sign_in"
  end

  root to: "member/homes#top"

  get "searches/search"

  scope module: :member do
    get "users/mypage" => "users#mypage"
    resources :users, only:[:show, :index, :edit, :update, :destroy]do
      resources :relationships, only:[:create, :destroy]
      member do
        get :followings, :followers
      end
    end

    resources :posts, only:[:index, :show, :edit, :create, :update, :destroy]do
      resources :post_comments, only:[:create, :destroy]
      resource :favorite, only:[:create, :destroy]
      resource :bookmark, only:[:create, :destroy]
    end
  end

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :users, only:[:index, :show] do
      patch "activate"
      patch "deactivate"
    end
  end

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #使用するコントローラ指定、不要なパスワード変更のルーティング削除
  devise_for :users,skip: [:passwords],controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
  }
  #使用するコントローラ指定、不要なパスワード変更と管理者登録のルーティング削除
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }

  root to: 'member/homes#top'

  scope module: :member do
    resources :users, only:[:show, :edit, :update, :destroy]do
      resources :relationships, only:[:create, :destroy]
      member do
        get :followings, :followers
      end
    end
    get 'users/information/edit' => 'users#edit'
    get 'users/confirm' => 'users#confirm'
    get 'users/mypage' => 'users#mypage'
      
    resources :posts, only:[:index, :show, :edit, :create, :update, :destroy]do
      resources :post_comments, only:[:create, :destroy]
      resource :favorite, only:[:create, :destroy]
    end
  end

  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :users, only:[:index, :show, :update]
  end
end

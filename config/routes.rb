Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 使用するコントローラ指定、不要なパスワード変更のルーティング削除
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'member/registrations',
    sessions: 'member/sessions'
  }
  # 使用するコントローラ指定、不要なパスワード変更と管理者登録のルーティング削除
  devise_for :admin, skip: %i[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  get 'latlngsearch/:lat/:lng' => 'member/posts#search', constraints: { lat: /\d+\.\d+/, lng: /\d+\.\d+/ }

  devise_scope :user do
    post 'member/guest_sign_in', to: 'member/sessions#guest_sign_in'
  end

  root to: 'member/homes#top'

  scope module: :member do
    get 'posts/search_tag/:id' => 'posts#search_tag', as: :post_search_tag
    get 'users/mypage' => 'users#mypage'
    get 'searches/search' => 'searches#search', as: :searches_search
    resources :users, only: %i[show index edit update destroy] do
      resources :relationships, only: %i[create destroy]
      member do
        get :followings, :followers
      end
    end

    resources :posts, only: %i[index show edit create update destroy] do
      resources :post_comments, only: %i[create destroy]
      resource :favorite, only: %i[create destroy]
      resource :bookmark, only: %i[create destroy]
    end
  end

  get 'admin' => 'admin/homes#top'
  namespace :admin do
    get 'searches/search' => 'searches#search'
    resources :posts, only: %i[show destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :users, only: %i[index show] do
      patch 'activate'
      patch 'deactivate'
    end
  end
end

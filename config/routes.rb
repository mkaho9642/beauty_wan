Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :salons, only: [:index, :show, :edit, :new, :create, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :reviews, only: [:show, :edit]
  end

  scope module: :public do
    devise_for :users
    root to: "homes#top"
    get 'home/about', to: 'homes#about', as: :about

    resources :salons, only: [:show, :index] do
      resources :reviews, only: [:new, :create]
    end

    resources :reviews, only: [:show]

    get 'users/confirm'
    patch 'users/quit'
    
    get "search" => "searches#search"

    resources :users, only: [:show, :edit, :update] do
      member do
        get 'mypage'
        get 'bookmark', action: :index
      end
    end
  end
end
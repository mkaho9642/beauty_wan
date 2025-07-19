Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get 'home/about', to: 'public/homes#about', as: :about

  resources :salons, controller: 'public/salons', only: [:show, :index] do
    resources :reviews, controller: 'public/reviews', only: [:new, :create]
    resource :favorites, controller: 'public/favorites', only: [:create, :destroy]
  end

  get 'salons/genre/:genre_id', to: 'public/salons#index', as: 'salons_by_genre'
  
  resources :reviews, controller: 'public/reviews', only: [:show] do
    resources :post_comments, controller: 'public/post_comments', only: [:create, :destroy]
  end

  get 'users/confirm', to: 'public/users#confirm'
  patch 'users/quit', to: 'public/users#quit'

  get "search" => "public/searches#search"

  resources :users, controller: 'public/users', only: [:show, :edit, :update] do
    member do
      get 'mypage'
      get 'bookmark', action: :index
    end
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :salons, only: [:index, :show, :edit, :new, :create, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :reviews, only: [:show, :edit]
  end
end
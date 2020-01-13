Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get '/sign_up', to: 'users/registrations#new'
    get '/login', to: 'users/sessions#new'
    delete '/logout', to: 'users/sessions#destroy'
  end

  resources :users, only: [:index, :show]
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: [:index]
end

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get '/sign_up', to: 'users/registrations#new'
    get '/login', to: 'users/sessions#new'
    delete '/logout', to: 'users/sessions#destroy'
  end

  resources :users, only: %i[index show]
  resources :users do
    member do
      get :following, :followers
      get 'password_edit', to: 'users#password_edit'
      patch 'password_update', to: 'users#password_update'
    end
  end

  resources :microposts do
    resources :comments, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :notifications, only: [:index]
end

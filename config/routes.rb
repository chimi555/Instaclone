# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/signup', to: 'users/registrations#new'
  end

  resources :users, only: [:index, :show]
end

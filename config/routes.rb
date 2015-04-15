Rails.application.routes.draw do
  
  resources :wikis

  devise_for :users
  resources :users, only: [:show, :update]

  root to: 'home#index'
end

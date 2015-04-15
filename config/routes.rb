Rails.application.routes.draw do
  
  resources :wikis

  devise_for :users
  resources :users, only: [:show]
  
  root to: 'home#index'
end

Rails.application.routes.draw do
  
  resources :wikis

  devise_for :users
  resources :users, only: [:show, :update]
  
  delete 'downgrade' => 'users#downgrade'

  resources :charges, only: [:new, :create]

  root to: 'home#index'
end

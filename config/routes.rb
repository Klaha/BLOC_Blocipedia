Rails.application.routes.draw do
  
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  devise_for :users
  resources :users, only: [:show, :update] 
  delete 'downgrade' => 'users#downgrade'
  resources :charges, only: [:new, :create]

  root to: 'home#index'
end

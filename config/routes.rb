Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  authenticated :user do
      root 'users#current_user_home', as: :authenticated_root
      get 'home', to: 'home#index'    
  end 
  resources :users do 
    member do
      get :following, :followers
    end
  end
  resources :posts do
  	resources :post_images
  	put :like, on: :member
  	resources :post_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end

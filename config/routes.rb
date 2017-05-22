Rails.application.routes.draw do
  

  get 'relationships/create'

  get 'relationships/destroy'

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'add_product', to: 'home#add_product'
  get 'add_service', to: 'home#add_service'
  
  authenticated :user do
      root 'users#show', as: :authenticated_root
      get 'home', to: 'home#index'    
  end 
  
  resources :users do 
      member do
        get :following, :followers 
        get :user_products
        get :user_conversations
        get :man_dress
        get :woman_dress
      end
      resources :images
  end
  
  resources :posts do
  	resources :post_images
  	put :like, on: :member
  	resources :post_comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :products
  
  resources :woman_dresses do
    put :upvote, on: :member
    resources :images
    resources :comments
  end
  
  resources :man_dresses do 
    put :upvote, on: :member
    resources :images
    resources :comments
  end

  resources :conversations do
    resources :messages
  end
  
  mount ActionCable.server => '/cable'
   
  
end

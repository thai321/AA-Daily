Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :artworks, only: [:show, :update, :create, :destroy]

  resources :users, only: [:show, :update, :create, :destroy] do
    resources :artworks, only: [:index]
  end
  # get 'users/', to: 'users#index', as: 'users'
  # post 'users/', to: 'users#create'
  # get 'user/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # put 'users/:id', to: 'users#update'
  # patch 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'


  resources :artwork_shares, only: [:create, :destroy]

  resources :comments

end

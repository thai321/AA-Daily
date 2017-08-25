Rails.application.routes.draw do
  get 'albums/new'

  get 'albums/create'

  get 'albums/edit'

  get 'albums/show'

  get 'albums/update'

  get 'albums/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session , only: [:new, :create, :destroy]
  resources :users, only: [:create, :new, :show]

  resources :bands
  root to: redirect('/session/new')
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session , only: [:new, :create, :destroy]
  resources :users, only: [:create, :new, :show]

  root to: redirect('/session/new')
end

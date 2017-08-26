Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session , only: [:new, :create, :destroy]
  resources :users, only: [:create, :new, :show]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]

  resources :notes, only: [:create, :destroy]

  root to: redirect('/session/new')
end

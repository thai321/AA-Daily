Rails.application.routes.draw do
  resources :users, only: [:index, :new, :show, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:index]

end

Rails.application.routes.draw do

  resources :users, only: [:index, :new, :show, :create] do
    resources :usercomments, only: [:create]
  end
  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:index]

  # resources :usercomments, only: [:new]

end

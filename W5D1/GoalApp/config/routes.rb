Rails.application.routes.draw do

  resources :users, only: [:index, :new, :show, :create] do
    resources :usercomments, only: [:create]
  end
  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:index] do
    resources :goal_comments, only: [:create]
  end

  # resources :goal_comments, only: [:new, :show]
  resources :comments, only: [:create]

end

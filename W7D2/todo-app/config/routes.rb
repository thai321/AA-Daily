Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :todos, only: [:index, :show, :create, :destroy, :update]
  end
end

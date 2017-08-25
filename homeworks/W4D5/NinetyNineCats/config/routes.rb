Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:new, :create] do
    post 'approve', on: :member
    post 'deny', on: :member
  end

  root to: redirect('/cats')
end

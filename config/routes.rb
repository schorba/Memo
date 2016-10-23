Rails.application.routes.draw do
  devise_for :users

  resources :games do
    member do
      put :play
      get :play
      put :open_picture
    end
  end

  resources :parts
  resources :pictures
  resources :categories, only: [:create, :update, :show]
  root 'games#index'

end
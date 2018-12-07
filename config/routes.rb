Rails.application.routes.draw do
  get 'grid_model/index'

  post 'grid_model/check'

  resources :bella_objects
  resources :biba_objects
  root to: 'visitors#index'
  devise_for :users
  resources :users
end

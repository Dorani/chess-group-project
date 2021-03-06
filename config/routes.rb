Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :games, only: [:new, :index, :create, :show, :update]
  resources :pieces, only: :update
  resources :boards, only: [:create, :show]
end

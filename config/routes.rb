Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index'
  get 'shop' => 'pages#shop'
  get 'about' => 'pages#about'

  resources :carts
  resources :product_items
  resources :orders
  resources :contacts, only: [:new, :create]
end

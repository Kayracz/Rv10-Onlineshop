Rails.application.routes.draw do
  get 'stock' => 'stock#index'
  get 'stock/index'
  post 'stock/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index'

  get 'women', to: 'products#women'
  get 'men', to: 'products#men'
  get 'kids', to: 'products#kids'
  get 'orderdashboard' => 'orders#orderdashboard'
  get 'about' => 'pages#about'
  get 'termsandconditions' => 'pages#termsandconditions'
  get 'envios' => 'pages#envios'
  get 'pagos' => 'pages#pagos'
  get 'devoluciones' => 'pages#devoluciones'

  get 'search', to: 'products#search', as: :products_search
  get 'search_results', to: 'products#perform_search', as: :perform_products_search
  get 'clear_filters', to: 'products#clear_filters', as: :products_clear_filters
  get 'filter', to: 'products#filter'

  post 'product_items/:item_id/add'    => "product_items#add_quantity",
    as: "product_items_add"

  post 'product_items/:item_id/reduce' => "product_items#reduce_quantity",
    as: "product_items_reduce"

  # get 'contraentrega' => 'orders#contraentrega'

  resources :carts, :product_items, :orders, :contacts,
    :products, :photos, :quantity, :categories, :transfers
end


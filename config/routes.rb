Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#home'
  get 'auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#logout'


  match '/orders/new', to: 'orders#new', via: :get
  match '/orders/create', to: 'orders#create', via: :post
  match '/orders/pay', to: 'orders#pay', via: :post
  match '/orders/capture_order', to: 'orders#capture_order', via: :post
  match '/orders/fetch', to: 'orders#fetch', via: :get
  match '/orders/show', to: 'orders#show', via: :get

  match '/client/home', to: 'client#home', via: :get

  match '/admin/home', to: 'admin#home', via: :get
  match '/admin/orders', to: 'admin#orders', via: :get
end

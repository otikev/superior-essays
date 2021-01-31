Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#home'
  get 'auth/:provider/callback' => 'sessions#omniauth'

  match '/client/home', to: 'client#home', via: :get
  match '/orders/new', to: 'orders#new', via: :get
  match '/orders/create', to: 'orders#create', via: :post

end

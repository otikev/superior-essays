Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#home'
  get 'auth/:provider/callback' => 'sessions#omniauth'

  match '/client/home', to: 'client#home', via: :get

end

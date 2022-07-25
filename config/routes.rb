Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'landing#home'

  mount Crono::Engine, at: '/crono'

  get '/sitemap' => 'sitemap#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#logout'

  match '/privacy', to: 'landing#privacy', via: :get
  match '/terms', to: 'landing#terms', via: :get
  match '/contact', to: 'landing#contact', via: :post

  match '/pricing', to: 'site#pricing', via: :get

  match '/orders/new', to: 'orders#new', via: :get
  match '/orders/create', to: 'orders#create', via: :post
  match '/orders/upload_resource', to: 'orders#upload_resource', via: :post
  match '/orders/delete_resource', to: 'orders#delete_resource', via: :patch
  match '/orders/update_status', to: 'orders#update_status', via: :patch
  match '/orders/download_resource', to: 'orders#download_resource', via: :get
  match '/orders/create_order', to: 'orders#create_order', via: :post
  match '/orders/capture_order', to: 'orders#capture_order', via: :post
  match '/orders/fetch', to: 'orders#fetch', via: :get
  match '/orders/show', to: 'orders#show', via: :get
  match '/orders/review', to: 'orders#review', via: :post

  match '/client/home', to: 'client#home', via: :get
  match '/client/orders_todo', to: 'client#orders_todo', via: :get
  match '/client/orders_complete', to: 'client#orders_complete', via: :get
  match '/client/orders_in_progress', to: 'client#orders_in_progress', via: :get
  match '/client/orders_closed', to: 'client#orders_closed', via: :get

  match '/admin/dashboard', to: 'admin#dashboard', via: :get
  match '/admin/orders_todo', to: 'admin#orders_todo', via: :get
  match '/admin/orders_complete', to: 'admin#orders_complete', via: :get
  match '/admin/orders_in_progress', to: 'admin#orders_in_progress', via: :get
  match '/admin/orders_closed', to: 'admin#orders_closed', via: :get
  match '/admin/users_clients', to: 'admin#users_clients', via: :get
  match '/admin/users_admins', to: 'admin#users_admins', via: :get
  match '/admin/user', to: 'admin#user', via: :get
  match '/admin/assign_voucher', to: 'admin#assign_voucher', via: :post
  match '/disable_user', to: 'admin#disable_user', via: :post
  match '/enable_user', to: 'admin#enable_user', via: :post
  
  match '/messages/create', to: 'messages#create', via: :post
  match '/messages/unread', to: 'messages#unread', via: :get
 
  match '/content/admin', to: 'content#admin', via: :get
  match '/content/new', to: 'content#new', via: :get
  match '/content/create', to: 'content#create', via: :post
  match '/content/update', to: 'content#update', via: :patch
  match '/content/edit', to: 'content#edit', via: :get

  match '/agent/question/exists', to: 'agent#question_exists', via: :get
  match '/agent/question/create', to: 'agent#question_create', via: :post

  match '/archives/list', to: 'archives#list', via: :get
  scope(path_names: { new: 'neu', edit: 'bearbeiten' }) do
    resources :contents, controller: 'archives', path: 'archives/show'
  end
end

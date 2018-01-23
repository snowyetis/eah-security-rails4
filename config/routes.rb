Rails.application.routes.draw do

  resources :product_details
  resources :quote_details, :products

  authenticated :user do
    root to: 'home#index', as: 'home'
  end

  unauthenticated :user do
    root 'home#index'
  end

  # TODO: Define routes for the Admin auth and unauth paths. i.e. a dashboard or sign in???
  # root :to => 'business_account#dashboard', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Business' }, :as => "business_root"
  # root :to => 'lender_account#dashboard', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Lender' }, :as => "lender_root"

  resources :sales, :quotes, :questionaires

  get 'home/index', to: 'home#index'
  get 'home/exit', to: 'home#exit'
  get 'home/pending', to: 'home#pending'

  get 'quotes/', to: 'quotes#show_quote'

  post 'products/send_quote_request', to: 'products#send_quote_request'

  devise_for :users,  controllers: {
                        sessions: 'users/sessions',
                        registrations: 'users/registrations',
                        confirmations: 'users/confirmations'
                      }

  resources :update, :path => "/users/sessions"

  devise_for :admins, controllers: {
                        sessions: 'admins/sessions',
                        registrations: 'admins/registrations',
                        confirmations: 'admins/confirmations'
                    }

  devise_scope :admin do
    get 'admins/signed_up', to: 'admins/registrations#index'
    match 'admins/get_approved_users/:approved/:buttonId', to: 'admins/registrations#get_approved_users', via: [:get]
    put 'admins/approve_user', to: 'admins/registrations#approve_user'

    get 'admins/products/index', to: 'admins/products#index'
    get 'admins/products/new', to: 'admins/products#new'
    post 'admins/products/create', to: 'admins/products#create'
    delete 'admins/products/:id', to: 'admins/products#destroy', as: 'destroy_admin_product'

    get 'admins/product_details/:id/edit', to: 'admins/product_details#edit'
    post 'admins/product_details/create', to: 'admins/product_details#create'
    put 'admins/product_details/update/:id', to: 'admins/product_details#update', as: 'update_admin_product_detail'
    delete 'admins/product_details/destroy/:id', to: 'admins/product_details#destroy', as: 'destroy_admin_product_detail'
  end


end

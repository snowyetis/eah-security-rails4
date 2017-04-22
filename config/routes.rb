Rails.application.routes.draw do

  resources :product_details
  resources :quote_details, :products

  authenticated :user do
    root to: 'home#index', as: 'home'
  end

  unauthenticated :user do
    root 'home#about'
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

  devise_for :admins, controllers: {
                        sessions: 'admins/sessions',
                        registrations: 'admins/registrations',
                        confirmations: 'admins/confirmations'
                    }

  devise_scope :admin do
    get 'admins/signed_up', to: 'admins/registrations#index'
    match 'admins/get_approved_users/:approved/:buttonId', to: 'admins/registrations#get_approved_users', via: [:get]
    # match 'admins/approve_user', to: 'admins/registrations#approve_user', via: [:put]
    # match 'admins/approve_all_users', to: 'admins/registrations#approve_all_users', via: [:put]
    put 'admins/approve_user', to: 'admins/registrations#approve_user'
    # patch "admins/:id", to: "admins/registrations#approve_user", as: "approve_user"
  end

  # post "/registrations/:id" => "registrations#show"
  # post "/hook" => "regstrations#hook"

end

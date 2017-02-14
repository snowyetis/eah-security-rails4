Rails.application.routes.draw do

  resources :quote_details
  root to: 'home#about'

  resources :sales, :quotes, :questionaires, :registrations

  get 'home/index', to: 'home#index'
  get 'home/exit', to: 'home#exit'
  get 'home/pending', to: 'home#pending'

  get 'quotes/', to: 'quotes#show_quote'

  post 'home/send_quote_request', to: 'home#send_quote_request'
  # post 'home/questionaire', to: 'home#questionaire'

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
    put 'admins/approve_user', to: 'admins/registrations#approve_user'
    # patch "admins/:id", to: "admins/registrations#approve_user", as: "approve_user"
  end

  post "/registrations/:id" => "registrations#show"
  post "/hook" => "regstrations#hook"

end

Rails.application.routes.draw do
  namespace :admin do
    get "dashboard/index"
  end
  get "payments/new"
  get "payments/create"
  get "profiles/show"
  get "pages/download"
  get "pages/quick_run"
  get "pages/infra_action"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  devise_for :users
  resources :sellers, only: [:index, :show]
  
  post "promote_to_seller", to: "users#promote", as: :promote_to_seller
  post "demote_to_buyer", to: "users#demote", as: :demote_to_buyer

  resources :products
  
  get "/about", to: "pages#about", as: :about
  get "/contact", to: "pages#contact", as: :contact
  get "/terms",   to: "pages#terms",   as: :terms
  get "/privacy", to: "pages#privacy", as: :privacy
  get "/settings", to: "pages#settings"


  # Static pages
  vpn_root = Rails.application.config.vpn_root
  get "/vpn", to: redirect(vpn_root)
  get "/download", to: "pages#download"
  get "/quick_run", to: "pages#quick_run"
  get "/infra_action", to: "pages#infra_action"

  #Landing page
    
  root to: "pages#landing" 
  get "/landing", to: "pages#landing"
    
  # Profile
  resource :profile, only: [:show]
  get "/profile/payment", to: "payments#new"
  post "/profile/payment", to: "payments#create"
  get "/profile/withdraw", to: "sellers#withdraw"


  #admin routes
  namespace :admin do
  get "dashboard", to: "dashboard#index"


  # Security endpoints
  post '/csp_report', to: 'application#csp_report'

  # Health check endpoint
  get '/health', to: 'health#show'
  end

  end
  
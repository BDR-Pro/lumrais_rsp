Rails.application.routes.draw do
  # Root and landing pages
  root to: "pages#landing"
  get "/landing", to: "pages#landing"

  # Authentication
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Dashboard routes
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/seller_dashboard", to: "dashboard#seller", as: :seller_dashboard

  # User profile and settings
  resource :profile, only: [:show, :edit, :update] do
    member do
      get :payment
      post :payment, to: 'payments#create'
      get :withdraw
      get :earnings
      get :jobs
      get :reviews
    end
  end

  # Seller management
  resources :sellers, only: [:index, :show] do
    member do
      post :promote
      post :demote
      get :reviews
      get :jobs
      get :earnings
    end
    resources :reviews, only: [:create, :update, :destroy]
  end

  # Job management
  resources :jobs, only: [:index, :show, :new, :create, :update] do
    member do
      post :start
      post :stop
      post :complete
    end
  end

  # Transaction management
  resources :transactions, only: [:index, :show] do
    collection do
      get :earnings
      get :spending
    end
  end

  # Static pages
  get "/about", to: "pages#about", as: :about
  get "/contact", to: "pages#contact", as: :contact
  get "/terms", to: "pages#terms", as: :terms
  get "/privacy", to: "pages#privacy", as: :privacy
  get "/settings", to: "pages#settings", as: :settings
  get "/download", to: "pages#download", as: :download
  get "/quick_run", to: "pages#quick_run", as: :quick_run
  get "/infra_action", to: "pages#infra_action", as: :infra_action

  # VPN routes
  vpn_root = Rails.application.config.vpn_root
  get "/vpn", to: redirect(vpn_root)

  # Admin namespace
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [:index, :show, :edit, :update]
    resources :sellers, only: [:index, :show, :edit, :update]
    resources :jobs, only: [:index, :show]
    resources :transactions, only: [:index, :show]
  end

  # API namespace
  namespace :api do
    namespace :v1 do
      resources :sellers, only: [:index, :show]
      resources :jobs, only: [:index, :show, :create]
      resources :transactions, only: [:index, :show]
    end
  end
  #Product 
  resources :products, only: [:index, :show]

  # Health and security endpoints
  get "up" => "rails/health#show", as: :rails_health_check
  post '/csp_report', to: 'application#csp_report'
  get '/health', to: 'health#show'
end
  
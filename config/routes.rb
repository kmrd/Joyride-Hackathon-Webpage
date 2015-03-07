Rails.application.routes.draw do

  root 'static#home'

  # sessions manipulation
  get    'sessions/new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


  get    'signup'                          => 'users#new'
  get    'user/edit'                       => 'users#edit'
  post   'user/edit'                       => 'users#update'
  get    'user/settings'                   => 'users#settings'
  patch  'user/settings'                   => 'users#update_settings'
#  resources :users, except: [:edit] do
#    member do
#      get :following, :followers
#    end
#    collection do 
#      resources :account_activations, only: [:edit]
#      resources :password_resets,     only: [:new, :create, :edit, :update]
#    end
#  end 

  get   'dashboard'   => 'dashboard#index'

  resources :devices


  ## omni auth add-on
  #get '/auth/:provider/callback'  => 'sessions#omniauth_endpoint'
  #get '/login/facebook'           => 'sessions#facebook', as: :facebook_login
  ##get '/signout'                  => 'sessions#destroy',  as: :signout
  #get '/auth/failure'             => 'sessions#failure'

end

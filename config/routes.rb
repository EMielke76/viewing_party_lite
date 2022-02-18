Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/dashboard', to: 'users#show'
  post '/dashboard', to: 'users#show'

  get '/discover', to: 'users#discover'
  # resources :users, only: [:create, :show] do
  resources :movies, only: [:index, :show] do
    resources :parties, only: [:new, :create]
  end
end

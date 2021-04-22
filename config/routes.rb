Rails.application.routes.draw do
  root 'app_pages#home'
  get '/about', to: 'app_pages#about'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :opinions, only: %i[create destroy]
  resources :followings, only: %i[create destroy]
end

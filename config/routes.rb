Rails.application.routes.draw do
  root 'app_pages#home'
  get '/about', to: 'app_pages#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

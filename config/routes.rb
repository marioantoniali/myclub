Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'
  #rajout routes
  post '/users/new',  to: 'users#create'
  post '/users/:id/edit', to: 'users#edit'
  get '/users/', to: 'users#index', as: 'index'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/private', to: 'static_pages#private'
end

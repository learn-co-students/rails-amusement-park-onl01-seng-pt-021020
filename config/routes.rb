Rails.application.routes.draw do
  root 'users#welcome'
  resources :users
  resources :attractions

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  post '/users/new', to:'users#create'
  post '/attractions/:id/edit', to: 'attractions#update'
  post '/attractions/new', to: 'attractions#create'
  post '/attractions/:id', to: 'rides#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

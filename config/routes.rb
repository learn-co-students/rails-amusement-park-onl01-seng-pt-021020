Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'
  resources :rides
  resources :users
  resources :attractions

  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#login'

  get '/signout', to: 'users#signout'
end

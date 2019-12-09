Rails.application.routes.draw do


  #get 'oauth_callback/index'
  get 'sign_up/new'
  # get 'sign_up/create'
  resources :sessions#, only: %i[create]
  resources :oauth_callback, only: [:index]
  resources :users
  resources :works
  resources :authenticate, only: [:show]
  namespace :api do
    namespace :v1 do
      resources :endpoint
    end
  end

  # get 'authorize/user/:id'
  #get '/authorize/:id', to: 'authorize#user'
  # get '/authorize/track', to: 'authorize#track'
  #get '/session/delete', to: 'session#delete'
  # get '/authentication_open_dialog', to: 'authenticate#open_dialog'
  #
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

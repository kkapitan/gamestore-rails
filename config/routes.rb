require 'api_constraints'

Gamestore::Application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      #users
      resources :users, :only => [:show, :create, :update, :destroy]

      #sessions
      resources :sessions, :only => [:create]
      delete '/sessions/logout', to: 'sessions#destroy'
      resources :sessions

      #games
      resources :games, :only => [:show, :create]

    end
  end
end

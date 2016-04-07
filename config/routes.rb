require 'api_constraints'

Gamestore::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      #users
      resources :users, :only => [:show, :create, :update, :destroy]

      #sessions
      resources :sessions, :only => [:create]
      delete '/sessions/logout', to: 'sessions#destroy'

      #games
      resources :games, :only => [:index, :show, :create, :update, :destroy]

      #libraries
      patch '/libraries/add', to: 'libraries#update'
    end
  end
end

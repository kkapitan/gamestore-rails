require 'api_constraints'

Gamestore::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"


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

      #reviews
      resources :reviews, :only => [:create]

      devise_for :users
    end
  end
end

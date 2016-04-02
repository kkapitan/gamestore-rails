require 'api_constraints'

Gamestore::Application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create]

      delete '/sessions/logout', to: 'sessions#destroy'
    end
  end
end

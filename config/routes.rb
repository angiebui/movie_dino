require 'sidekiq/web'
require 'admin_constraint'

MovieDino::Application.routes.draw do

  resources :sessions, defaults: { format: 'json'}
  resources :users
  resources :outings
  resources :attendees

  root to: 'pages#index'

  match '/loading', to: 'outings#loading', as: 'loading'
  match '/status', to: 'outings#status', as: 'status'

  match '/start',                  to: 'outings#cache'
  match 'auth/:provider/callback', to: 'sessions#create'
  match '/profile',                to: 'users#show', as: 'profile'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '/users', to: 'pages#index'
  match '/outings/:id/form' , to: 'attendees#new'
  match '/:provider/auth', to: 'sessions#create'

  mount Sidekiq::Web, at: "/admin/sidekiq", :constraints => AdminConstraint.new
  ###################################
  #please dont move this, it's greedy.
  #maybe we use /m/:link instead?
  match '/:link', to: 'attendees#new', :as => 'outings_form'
end

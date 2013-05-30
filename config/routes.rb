require 'sidekiq/web'
require 'admin_constraint'

MovieDino::Application.routes.draw do

  root to: 'pages#index'

  resources :sessions, defaults: { format: 'json'}
  resources :users
  resources :outings
  resources :attendees
  match '/outings/:id/form', to: 'attendees#new'
  match '/profile',          to: 'users#show', as: 'profile'
  match '/loading',          to: 'outings#loading', as: 'loading'
  match '/status',           to: 'outings#status', as: 'status'
  match '/start',            to: 'outings#cache'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure',            to: redirect('/')
  match 'signout',                 to: 'sessions#destroy', as: 'signout'
  match '/:provider/auth',         to: 'sessions#create'

  mount Sidekiq::Web, at: "/admin/sidekiq", :constraints => AdminConstraint.new
  ###################################
  #please dont move this, it's greedy.
  #maybe we use /m/:link instead?
  match '/:link', to: 'attendees#new', :as => 'outings_form'
end

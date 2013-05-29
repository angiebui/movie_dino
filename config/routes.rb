MovieDino::Application.routes.draw do

  resources :sessions, defaults: { format: 'json'}
  resources :users
  resources :outings
  resources :attendees

  root to: 'pages#index'
  get '/outings:id/form', to: 'attendees#new'

  match '/loading', to: 'outings#loading', as: 'loading'
  match '/status', to: 'outings#status', as: 'status'

  match '/start',                  to: 'outings#cache'
  match 'auth/:provider/callback', to: 'sessions#create'
  match '/profile',                to: 'users#show', as: 'profile'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '/users', to: 'pages#index'
  match '/outings/:id/form' , to: 'attendees#new', :as => 'outings_form'
  match '/:provider/auth', to: 'sessions#create'

  ###################################
  #please dont move this, it's greedy.
  #maybe we use /m/:link instead?
  match '/:link', to: 'outings#link_show'
end

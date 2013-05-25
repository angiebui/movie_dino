MovieBuddy::Application.routes.draw do

  resources :sessions
  resources :users
  resources :outings

  root to: 'pages#index'

  match '/start', to: 'outings#new'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'



  ###################################
  #please dont move this, it's greedy.
  #maybe we use /m/:link instead?
  match '/:link', to: 'outings#link_show'
end

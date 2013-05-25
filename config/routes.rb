MovieBuddy::Application.routes.draw do

  resources :sessions
  resources :users do
    resources :outings
  end

  root to: 'pages#index'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'



  ###################################
  #please dont move this, it's greedy.
  #maybe we use /m/:link instead?
  match '/:link', to: 'outings#link_show'
end

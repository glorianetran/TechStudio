Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  resources :projects
  
  get 'projects/' => redirect('projects/index')
  
  # get 'projects/index'

  # get 'projects/new'

  # get 'projects/show'
  
  # tags
  get 'tags/:tag', to: 'projects#index', as: :tag

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pages/home'
  get 'pages/about'
  root :to => redirect('pages/home')
  
  # authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
end

Rails.application.routes.draw do
  resources :chatrooms
  get 'sessions/create'

  get 'sessions/destroy'
  
  resources :users

  resources :projects
  
  get 'projects/' => redirect('projects/index')
  
  # collaborators
  post 'projects/:id/request', to: 'projects#request_collab', as: :request_collab
  post 'projects/:id/approve', to: 'projects#approve', as: :approve
  post 'projects/:id/reject', to: 'projects#reject', as: :reject
  post 'projects/:id/delete_collaborator', to: 'projects#delete_collaborator', as: :delete_collaborator
  
  # tags
  get 'tags/:tag', to: 'projects#index', as: :tag

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'pages#home'
  get '/about' => 'pages#about'
  # root :to => redirect('pages/home')
  
  # authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
end

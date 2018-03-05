Rails.application.routes.draw do
  resources :projects
  
  get 'projects/' => redirect('projects/index')
  
  # get 'projects/index'

  # get 'projects/new'

  # get 'projects/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pages/home'
  get 'pages/about'
  root :to => redirect('pages/home')
end

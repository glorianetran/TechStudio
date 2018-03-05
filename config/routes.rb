Rails.application.routes.draw do
  get 'projects/' => redirect('projects/index')
  
  get 'projects/index'

  get 'projects/new'

  get 'projects/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'static_pages/home'
  get 'static_pages/about'
  root :to => redirect('static_pages/home')
end

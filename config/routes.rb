Rails.application.routes.draw do
  get 'tasks/index'

  get 'tasks/new'

  get 'tasks/create'

  get 'tasks/show'

  get 'tasks/edit'

  get 'tasks/update'

  get 'tasks/destroy'

  get 'projects/create'

  get 'projects/destroy'

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :pjmembers
    end
  end
  
  resources :projects do
    member do
      get :pjmembers
    end
  end
  
  resources :pjmembers, only: [:create, :destroy]
  
  resources :tasks
end

Rails.application.routes.draw do
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
    resources :tasks
    member do
      get :pjmembers
    end
  end
  
  resource :pjmembers, only: [:create, :destroy]
  resource :assign_members, only: [:create, :destroy]
end

Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root'static_pages#index'
  get '/signup', to:'users#new'
  post'/signup',to:'users#create'
  get    '/login',   to: 'sessions#new'   
  post   '/login',   to: 'sessions#create'   
  delete '/logout',  to: 'sessions#destroy'


  resources :static_pages
  resources :settings
  resources:users
  resources :comments 
  resources :cards  
  resources :password_resets
end

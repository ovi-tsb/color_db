Rails.application.routes.draw do
  get 'customers/index'
  get 'customers/edit'
  get 'customers/new'
  get 'customers/update'
  get 'customers/destroy'
  get 'inks/index'
  get 'inks/new'
  get 'inks/create'
  get 'inks/show'
  get 'inks/destroy'
  # get 'users/index'

  namespace :admin do
      resources :users
      resources :inks
      resources :admin_users
      resources :customer_users
      resources :super_users

      root to: "users#index"
    end
    authenticated do
      root :to => 'inks#index'
    end
  
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#homepage'

  resources :inks
  resources :customers
  resources :users

end

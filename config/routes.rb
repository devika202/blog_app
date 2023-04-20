Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  post '/' => 'pages#home'
  get 'index', to: 'pages#index'
  resources :articles
  resources :users, except: [:new]
  resources :categories, except: [:destroy]
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  resources :articles do
    resources :comments
  end
  
end

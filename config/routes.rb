Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'pages#home'
  post '/' => 'pages#home'
  get 'index', to: 'pages#index'
  resources :articles
  get 'my_articles', to: 'articles#my_articles', as: 'my_articles'
  resources :users, except: [:new]
  resources :categories, except: [:destroy]
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  resources :articles do
    resources :comments
  end
  namespace :admin do
    resources :articles, only: [:index]
  end
end

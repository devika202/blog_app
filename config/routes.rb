Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'pages#home'
  post '/' => 'pages#home'
  get 'index', to: 'pages#index'
  get 'home', to: 'pages#home'

  resources :articles
  get 'my_articles', to: 'articles#my_articles', as: 'my_articles'
  resources :users, except: [:new]
  resources :categories
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  resources :articles do
    resources :comments
  end
  namespace :admin do
    resources :articles, only: [:index]
  end
  resources :articles do
    member do
      put 'approve'
      put 'decline'
    end
  end
  resources :articles do
    resources :likes, only: [:create, :destroy]
  end
  resources :articles do
    resources :likes, only: [:create, :destroy]
    post 'dislikes', to: 'likes#create_dislike', as: 'create_dislike'
    delete 'dislikes', to: 'likes#destroy_dislike', as: 'destroy_dislike'
  end
end
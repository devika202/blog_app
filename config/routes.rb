Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  root 'pages#home'
  post '/' => 'pages#home'
  get 'index', to: 'pages#index'
  get 'home', to: 'pages#home'
  namespace :api, defaults: { format: 'json' } do
    resources :articles, only: [:index, :show] do
      collection do
        get 'filter_config', to: 'articles#filter_config'
        get 'tag_suggestions', to: 'articles#tag_suggestions'
        get 'status_options', to: 'articles#status_options'
        get 'filter_articles', to: 'articles#filter_articles'

      end
    end
  end
  namespace :api do
    get 'filter_config', to: 'articles#filter_config'
  end
  namespace :api do
      resources :filters, only: [:index]
  end
  namespace :api do
    resources :articles, defaults: { format: :json }, serializer: ArticleSerializer
  end
  
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
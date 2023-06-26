require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'GET likes#create' do
    it 'routes to likes#create' do
      expect(get: '/likes/create').to route_to('likes#create')
    end
  end

  describe 'GET likes#destroy' do
    it 'routes to likes#destroy' do
      expect(get: '/likes/destroy').to route_to('likes#destroy')
    end
  end

#   describe 'Ckeditor engine' do
#     it 'mounts the Ckeditor engine at /ckeditor' do
#       expect(mount(Ckeditor::Engine => '/ckeditor')).to be_truthy
#     end
#   end

describe 'Devise routes' do
    it 'routes to devise_for :users' do
      expect(get: '/users/sign_in').to route_to('devise/sessions#new')
      expect(post: '/users/sign_in').to route_to('devise/sessions#create')
      expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
      expect(get: '/users/password/new').to route_to('devise/passwords#new')
      expect(get: '/users/password/edit').to route_to('devise/passwords#edit')
      expect(put: '/users/password').to route_to('devise/passwords#update')
      expect(patch: '/users/password').to route_to('devise/passwords#update')
      expect(post: '/users/password').to route_to('devise/passwords#create')
      expect(get: '/users/cancel').to route_to('devise/registrations#cancel')
      expect(get: '/users/sign_up').to route_to('devise/registrations#new')
      expect(get: '/users/edit').to route_to('devise/registrations#edit')
      expect(put: '/users').to route_to('devise/registrations#update')
      expect(patch: '/users').to route_to('devise/registrations#update')
      expect(delete: '/users').to route_to('devise/registrations#destroy')
      expect(post: '/users').to route_to('devise/registrations#create')
    end
  end


  describe 'Root path' do
    it 'routes to pages#home' do
      expect(get: '/').to route_to('pages#home')
    end

    it 'routes POST / to pages#home' do
      expect(post: '/').to route_to('pages#home')
    end
  end

  describe 'GET /index' do
    it 'routes to pages#index' do
      expect(get: '/index').to route_to('pages#index')
    end
  end

  describe 'Resourceful routes for articles' do
    it 'routes to articles#index' do
      expect(get: '/articles').to route_to('articles#index')
    end

    it 'routes to articles#new' do
      expect(get: '/articles/new').to route_to('articles#new')
    end

    it 'routes to articles#create' do
      expect(post: '/articles').to route_to('articles#create')
    end

    it 'routes to articles#show' do
      expect(get: '/articles/1').to route_to('articles#show', id: '1')
    end

    it 'routes to articles#edit' do
      expect(get: '/articles/1/edit').to route_to('articles#edit', id: '1')
    end

    it 'routes to articles#update' do
      expect(put: '/articles/1').to route_to('articles#update', id: '1')
    end

    it 'routes to articles#destroy' do
      expect(delete: '/articles/1').to route_to('articles#destroy', id: '1')
    end

    it 'routes to articles#my_articles' do
      expect(get: '/my_articles').to route_to('articles#my_articles')
    end
  end

  describe 'Resourceful routes for users' do
    it 'routes to users#index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to users#show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to users#edit' do
      expect(get: '/users/1/edit').to route_to('users#edit', id: '1')
    end

    it 'routes to users#update' do
      expect(put: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to users#destroy' do
      expect(delete: '/users/1').to route_to('users#destroy', id: '1')
    end
  end

  describe 'Resourceful routes for categories' do
    it 'routes to categories#index' do
      expect(get: '/categories').to route_to('categories#index')
    end

    it 'routes to categories#new' do
      expect(get: '/categories/new').to route_to('categories#new')
    end

    it 'routes to categories#create' do
      expect(post: '/categories').to route_to('categories#create')
    end

    it 'routes to categories#show' do
      expect(get: '/categories/1').to route_to('categories#show', id: '1')
    end

    it 'routes to categories#edit' do
      expect(get: '/categories/1/edit').to route_to('categories#edit', id: '1')
    end

    it 'routes to categories#update' do
      expect(put: '/categories/1').to route_to('categories#update', id: '1')
    end

    it 'routes to categories#destroy' do
      expect(delete: '/categories/1').to route_to('categories#destroy', id: '1')
    end
  end

  

  describe 'Nested resource routes for articles and comments' do
    it 'routes to comments#index' do
      expect(get: '/articles/1/comments').to route_to('comments#index', article_id: '1')
    end

    it 'routes to comments#new' do
      expect(get: '/articles/1/comments/new').to route_to('comments#new', article_id: '1')
    end

    it 'routes to comments#create' do
      expect(post: '/articles/1/comments').to route_to('comments#create', article_id: '1')
    end

    it 'routes to comments#show' do
      expect(get: '/articles/1/comments/1').to route_to('comments#show', article_id: '1', id: '1')
    end

    it 'routes to comments#edit' do
      expect(get: '/articles/1/comments/1/edit').to route_to('comments#edit', article_id: '1', id: '1')
    end

    it 'routes to comments#update' do
      expect(put: '/articles/1/comments/1').to route_to('comments#update', article_id: '1', id: '1')
    end

    it 'routes to comments#destroy' do
      expect(delete: '/articles/1/comments/1').to route_to('comments#destroy', article_id: '1', id: '1')
    end
  end

  describe 'Admin namespace routes' do
    it 'routes to admin/articles#index' do
      expect(get: '/admin/articles').to route_to('admin/articles#index')
    end
  end

  describe 'Member routes for articles' do
    it 'routes to articles#approve' do
      expect(put: '/articles/1/approve').to route_to('articles#approve', id: '1')
    end

    it 'routes to articles#decline' do
      expect(put: '/articles/1/decline').to route_to('articles#decline', id: '1')
    end
  end

  describe 'Nested resource routes for articles and likes' do
    it 'routes to likes#create' do
      expect(post: '/articles/1/likes').to route_to('likes#create', article_id: '1')
    end

    
  end

  describe 'Additional routes for articles and likes' do
    it 'routes to likes#create_dislike' do
      expect(post: '/articles/1/dislikes').to route_to('likes#create_dislike', article_id: '1')
    end

    it 'routes to likes#destroy_dislike' do
      expect(delete: '/articles/1/dislikes').to route_to('likes#destroy_dislike', article_id: '1')
    end
  end
end

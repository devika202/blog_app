require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    context 'when user is signed in' do
      before { sign_in create(:user) }  

      it 'redirects to articles path' do
        get :home

    end
    end

    context 'when user is not signed in' do
      before { sign_out :user }

      it 'renders the home template' do
        get :home
      end
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index

    end
  end
end

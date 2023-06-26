require 'rails_helper'
require 'factory_bot_rails'
RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

    describe 'GET #show' do
        let(:user) { FactoryBot.create(:user) }

        context 'when user is logged in and accessing own profile' do
        before { sign_in(user) }

        it 'renders the show template' do
            get :show, params: { id: user.id }
            expect(response).to have_http_status(:found)
        end
        end
    end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_attributes }
        }
      end

      it 'sets the session user_id' do
        post :create, params: { user: valid_attributes }
        expect(session[:user_id])
      end

      it 'redirects to the articles path' do
        post :create, params: { user: valid_attributes }
      end

      it 'sets a flash notice message' do
        post :create, params: { user: valid_attributes }
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:user, name: '') }

      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: invalid_attributes }
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      get :edit, params: { id: user.id }
    end

    it 'assigns the requested user to @user' do
      expect(assigns(:user))
    end

    it 'renders the edit template' do

    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:user, name: 'New Name') }

      before do
        sign_in(user)
        put :update, params: { id: user.id, user: valid_attributes }
      end

      it 'updates the user attributes' do
        user.reload
        expect(user.name)
      end

      it 'redirects to the user profile' do

    end

      it 'sets a flash notice message' do

    end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:user, name: '') }

      before do
        sign_in(user)
        put :update, params: { id: user.id, user: invalid_attributes }
      end

      it 'does not update the user attributes' do
        user.reload
        expect(user.name).not_to be_empty
      end

      it 'renders the edit template' do

    end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'destroys the user' do
      expect {
        delete :destroy, params: { id: user.id }
      }
    end

    it 'clears the session user_id if the current user is destroyed' do
      delete :destroy, params: { id: user.id }
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the articles path' do
      delete :destroy, params: { id: user.id }
    end

    it 'sets a flash notice message' do
      delete :destroy, params: { id: user.id }
    end
  end
end

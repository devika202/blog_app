require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #new' do
      let(:user) { create(:user) }

      before do
        sign_in user
        get :new
      end

    context 'when user is not signed in' do
      before { get :new }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { category: { name: 'Test Category' } } }

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      context 'with valid attributes' do
        it 'creates a new category' do
          expect {
            post :create, params: valid_attributes
          }
        end

        it 'sets the flash notice' do
          post :create, params: valid_attributes
        end

        it 'redirects to the created category' do
          post :create, params: valid_attributes        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { { category: { name: '' } } }

        it 'does not create a new category' do
          expect {
            post :create, params: invalid_attributes
          }.not_to change(Category, :count)
        end

        it 'renders the new template' do
          post :create, params: invalid_attributes
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    let(:category) { create(:category) }

    before { get :show, params: { id: category.id } }

    it 'renders the show template' do
    end

    it 'assigns the requested category' do
      expect(assigns(:category))
    end

    it 'assigns the articles for the category' do
      expect(assigns(:articles))
    end
  end

  describe 'GET #edit' do
    let(:category) { create(:category) }

    before { get :edit, params: { id: category.id } }

    it 'renders the edit template' do
    end

    it 'assigns the requested category' do
      expect(assigns(:category))
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category) }

    context 'when user is signed in and is an admin' do
      let(:admin_user) { create(:user, admin: true) }

      before do
        sign_in admin_user
        delete :destroy, params: { id: category.id }
      end

      it 'deletes the category' do
        expect(Category.exists?(category.id))
      end

      it 'sets the flash notice' do
      end

      it 'redirects to the categories index page' do
      end
    end

    context 'when user is signed in but is not an admin' do
      let(:user) { create(:user, admin: false) }

      before do
        sign_in user
        delete :destroy, params: { id: category.id }
      end

      it 'does not delete the category' do
        expect(Category.exists?(category.id)).to be_truthy
      end

      it 'sets the flash alert' do
      end

      it 'redirects to the categories index page' do
      end
    end

    context 'when user is not signed in' do
      before { delete :destroy, params: { id: category.id } }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:category) { create(:category) }
    let(:valid_attributes) { { category: { name: 'Updated Category' } } }

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      context 'with valid attributes' do
        before { patch :update, params: { id: category.id, category: valid_attributes[:category] } }

        it 'updates the category' do
          category.reload
          expect(category.name)
        end

        it 'sets the flash notice' do
          expect(flash[:notice])
        end

        it 'redirects to the updated category' do
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { { category: { name: '' } } }

        before { patch :update, params: { id: category.id, category: invalid_attributes[:category] } }

        it 'does not update the category' do
          category.reload
          expect(category.name).not_to eq('')
        end

        it 'renders the edit template' do
        end
      end
    end

    context 'when user is not signed in' do
      before { patch :update, params: { id: category.id, category: valid_attributes[:category] } }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #index' do
    before { get :index }

    it 'renders the index template' do
    end
  end
end

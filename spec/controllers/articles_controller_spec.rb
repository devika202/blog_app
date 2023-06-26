require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #show" do
    let(:article) { FactoryBot.create(:article) }

    it "renders the show template" do
      get :show, params: { id: article.id }
    end

    context "when the article is approved" do
      let(:approved_article) { FactoryBot.create(:article, status: "approved") }

      it "renders the show template" do
        get :show, params: { id: approved_article.id }
      end
    end

    context "when the article is not approved" do
      let(:pending_article) { FactoryBot.create(:article, status: "pending") }

      it "redirects to my_articles_path" do
        get :show, params: { id: pending_article.id }
        expect(response).to redirect_to(my_articles_path)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
    end
  end

  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:valid_attributes) { FactoryBot.attributes_for(:article) }
    let(:invalid_attributes) { FactoryBot.attributes_for(:article, title: nil) }

    context "when user is authenticated" do
      before { sign_in user }

      context "with valid attributes" do
        it "creates a new article" do
          expect {
            post :create, params: { article: valid_attributes }
          }
        end

        it "redirects to the created article" do
          post :create, params: { article: valid_attributes }
          expect(flash[:notice])
        end
      end

      context "with invalid attributes" do
        it "does not create a new article" do
          expect {
            post :create, params: { article: invalid_attributes }
          }.not_to change(Article, :count)
        end

        it "renders the new template with unprocessable_entity status" do
          post :create, params: { article: invalid_attributes }
          expect(response.status)
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        post :create, params: { article: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article, user: user) }

    context "when user is authenticated" do
      before { sign_in user }

      it "renders the edit template" do
        get :edit, params: { id: article.id }
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        get :edit, params: { id: article.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article, user: user) }
    let(:valid_attributes) { FactoryBot.attributes_for(:article, title: "Updated Title") }
    let(:invalid_attributes) { FactoryBot.attributes_for(:article, title: nil) }

    context "when user is authenticated" do
      before { sign_in user }

      context "with valid attributes" do
        it "updates the article" do
          patch :update, params: { id: article.id, article: valid_attributes }
          article.reload
          expect(article.title)
        end

        it "redirects to the updated article" do
          patch :update, params: { id: article.id, article: valid_attributes }
          expect(flash[:notice])
        end
      end

      context "with invalid attributes" do
        it "does not update the article" do
          patch :update, params: { id: article.id, article: invalid_attributes }
          article.reload
          expect(article.title).not_to be_nil
        end

        it "renders the edit template with unprocessable_entity status" do
          patch :update, params: { id: article.id, article: invalid_attributes }
          expect(response.status)
        end
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        patch :update, params: { id: article.id, article: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article, user: user) }

    context "when user is authenticated" do
      before { sign_in user }

      it "destroys the article" do
        expect {
          delete :destroy, params: { id: article.id }
        }
      end

      it "redirects to articles_path" do
        delete :destroy, params: { id: article.id }
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        delete :destroy, params: { id: article.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

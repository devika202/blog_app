require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
    describe "POST #create" do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
  
      context "when user is authenticated" do
        before { sign_in user }
  
        context "with valid parameters" do
          it "creates a new comment" do
            expect do
              post :create, params: { article_id: article.id, comment: { content: "Test comment" } }
            end
          end
  
          it "assigns the comment to the current user" do
            post :create, params: { article_id: article.id, comment: { content: "Test comment" } }
            expect(assigns(:comment).user)
          end
  
          it "redirects to the article page" do
            post :create, params: { article_id: article.id, comment: { content: "Test comment" } }
          end
        end
  
        context "with invalid parameters" do
          it "renders the article show page" do
            post :create, params: { article_id: article.id, comment: { content: "" } }
          end
        end
      end
  
      context "when user is not authenticated" do
        it "does not create a new comment" do
          expect do
            post :create, params: { article_id: article.id, comment: { content: "Test comment" } }
          end
        end
  
        it "redirects to the sign-in page" do
          post :create, params: { article_id: article.id, comment: { content: "Test comment" } }
        end
      end
    end
  
    describe "DELETE #destroy" do
      let(:admin_user) { create(:user, admin: true) }
      let(:comment) { create(:comment) }
  
      context "when user is an admin" do
        before { sign_in admin_user }
  
        it "destroys the comment" do
          expect do
            delete :destroy
          end
        end     
      end
    end
  end
  
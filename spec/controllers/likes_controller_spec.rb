require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'when user is not the author of the article' do
        it 'creates a like for the article' do
          expect {
            post :create, params: { article_id: article.id }
          }
        end

        it 'redirects to the article with a success notice' do
          post :create, params: { article_id: article.id }
        end
      end

      context 'when user is the author of the article' do
        it 'does not create a like for the article' do
          article.update(author: user)
          expect {
            post :create, params: { article_id: article.id }
          }.not_to change(Like, :count)
        end

        it 'redirects to the article with an alert message' do
          article.update(author: user) 
          post :create, params: { article_id: article.id }
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        post :create, params: { article_id: article.id }

    end
    end
  end

  describe 'DELETE #destroy' do
    let!(:like) { create(:like, article: article, user: user) }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'destroys the like for the article' do
        expect {
          delete :destroy, params: { article_id: article.id }
        }
      end

      it 'redirects to the article with a success notice' do
        delete :destroy, params: { article_id: article.id }
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        delete :destroy, params: { article_id: article.id }
      end
    end
  end

  describe 'POST #create_dislike' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'when user is not the author of the article' do
        it 'creates a dislike for the article' do
          expect {
            post :create_dislike, params: { article_id: article.id }
          }
        end

        it 'redirects to the article with a success notice' do
          post :create_dislike, params: { article_id: article.id }
        end
      end

      context 'when user is the author of the article' do
        it 'does not create a dislike for the article' do
          article.update(author: user) 
          expect {
            post :create_dislike, params: { article_id: article.id }
          }.not_to change(Dislike, :count)
        end

        it 'redirects to the article with an alert message' do
          article.update(author: user) 
          post :create_dislike, params: { article_id: article.id }
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        post :create_dislike, params: { article_id: article.id }
      end
    end
  end

  describe 'DELETE #destroy_dislike' do
    let!(:dislike) { create(:dislike, article: article, user: user) }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'destroys the dislike for the article' do
        expect {
          delete :destroy_dislike, params: { article_id: article.id }
        }
      end

      it 'redirects to the article with a success notice' do
        delete :destroy_dislike, params: { article_id: article.id }
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        delete :destroy_dislike, params: { article_id: article.id }
      end
    end
  end
end

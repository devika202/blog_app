require 'rails_helper'
RSpec.describe Admin::ArticlesController, type: :controller do
    describe "GET #index" do
      it "assigns all articles to @articles" do
        articles = create_list(:article, 3) 
        get :index
        expect(assigns(:articles)).to eq(articles)
      end
  
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
  
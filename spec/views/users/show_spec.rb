require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
    include Devise::Test::ControllerHelpers

  let(:user) { create(:user) } 

  before do
    assign(:user, user)
    assign(:articles, [])
    allow(view).to receive(:will_paginate)
  end

  context 'when the user is signed in and it is their own profile' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'displays the user name in the header' do
      expect(rendered).to have_css('h1', text: "#{user.name}'s profile")
    end

    it 'displays a link to edit the user profile' do
      expect(rendered).to have_link('Edit your profile', href: edit_user_registration_path, class: 'btn btn-info')
    end
  end

  context 'when displaying articles' do
    let(:article) { create(:article, user: user) } 

    before do
      assign(:articles, [article])
      render
    end

    it 'displays the article title as a link' do
      expect(rendered).to have_link(article.title, href: article_path(article), class: 'text-success')
    end

    it 'displays the article categories if any' do
      expect(rendered).to have_css('.mt-2', text: article.categories.first.name)
    end

    it 'displays the article image if attached' do
      expect(rendered).to have_css('img.card-img-top')
    end

    it 'displays the article author name as a link' do
      expect(rendered).to have_link(user.name, href: user_path(user))
    end

    it 'displays the article description' do
      expect(rendered).to have_text(truncate(article.description, length: 100))
    end

    it 'displays the article status' do
      expect(rendered).to have_text("Status: #{article.status}")
    end

    it 'displays a link to view the article' do
      expect(rendered).to have_link('View', href: article_path(article), class: 'btn btn-outline-info')
    end

    context 'when the user is signed in and it is their own article' do
      before do
        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(user)
        render
      end
    end

    context 'when the user is not signed in' do
      before do
        allow(view).to receive(:user_signed_in?).and_return(false)
        render
      end

      it 'does not display a link to edit the article' do
        expect(rendered).not_to have_link('Edit')
      end

      it 'does not display a link to delete the article' do
        expect(rendered).not_to have_link('Delete')
      end
    end
  end 
end
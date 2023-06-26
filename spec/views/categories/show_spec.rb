require 'rails_helper'

RSpec.describe 'categories/show', type: :view do
  let(:category) { FactoryBot.create(:category) }
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article, user: user) }

  before do
    allow(view).to receive(:will_paginate)

    assign(:category, category)
    assign(:articles, [article])
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it 'displays the category name' do
    expect(rendered).to have_selector('h1.text-center', text: category.name)
  end

  context 'when the user is an admin' do
    before do
      allow(user).to receive(:admin?).and_return(true)
      render
    end

    it 'displays the "Edit category name" link' do
      expect(rendered).to have_link('Edit category name', href: edit_category_path(category))
    end
  end

  it 'displays the article title' do
    expect(rendered).to have_selector('h3.text-center', text: 'Articles')
    expect(rendered).to have_selector('.card-title', text: article.title)
  end

  it 'displays the article image' do
    expect(rendered).to have_selector('.card-img-top')
  end

  it 'displays the article author' do
    expect(rendered).to have_link(user.name, href: user_path(user))
  end

  it 'displays the article description' do
    expect(rendered).to have_selector('.card-text', text: article.description)
  end

  it 'displays the "View" link' do
    expect(rendered).to have_link('View', href: article_path(article))
  end

  context 'when the user is the article owner or an admin' do
    before do
      allow(article).to receive(:user).and_return(user)
      render
    end

    it 'displays the "Edit" and "Delete" links' do
      expect(rendered).to have_link('Edit', href: edit_article_path(article))
      expect(rendered).to have_link('Delete', href: article_path(article))
    end
  end
  it 'displays the pagination links' do
    expect(rendered).to have_selector('.flickr_pagination')
  end
end

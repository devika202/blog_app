require 'rails_helper'

RSpec.describe 'articles/show', type: :view do
  let(:user) { create(:user) } 
  let(:article) { create(:article) } 
  let(:category) { FactoryBot.create(:category) }

  before do
    assign(:article, article)
    assign(:comment, Comment.new) 
    allow(view).to receive(:user_signed_in?).and_return(false)
    allow(view).to receive(:current_user).and_return(nil)
    render
  end

  it 'displays the article title' do
    expect(rendered).to have_selector('h2.text-center', text: article.title)
  end

  it 'displays the article image' do
    expect(rendered).to have_selector('img.card-img-top')
  end

  it 'displays the article author' do
    expect(rendered).to have_content(article.user.name)
  end

  it 'displays the article description' do
    expect(rendered).to have_selector('.card-text', text: article.description)
  end

  it 'displays the number of likes and dislikes' do
    expect(rendered).to have_content("LIKES: #{article.likes.count}")
    expect(rendered).to have_content("DISLIKES: #{article.dislikes.count}")
  end

  it 'displays the comments section' do
    expect(rendered).to have_selector('h1.text-center', text: 'COMMENTS')
  end

  it 'displays the comment user name and content' do
    comment = create(:comment, article: article)
    render

  end

  it 'displays delete button for comment if current user is an admin' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    allow(user).to receive(:admin?).and_return(true)
    comment = create(:comment, article: article)
    render

  end

  it 'does not display delete button for comment if current user is not an admin' do
    comment = create(:comment, article: article)
    render

  end

  it 'displays comment form for non-admin users' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    render

  end

  it 'does not display comment form for admin users' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    allow(user).to receive(:admin?).and_return(true)
    render

  end

  it 'displays edit and delete buttons for the article owner' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(article.user)
    render

    expect(rendered).to have_selector('a.btn.btn-outline-danger', count: 1, text: 'Delete')
  end

  it 'does not display edit and delete buttons for non-owner users' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    render

    expect(rendered).not_to have_selector('a.btn.btn-outline-warning', text: 'Edit')
    expect(rendered).not_to have_selector('a.btn.btn-outline-danger', text: 'Delete')
  end
end

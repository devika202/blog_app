require 'rails_helper'

RSpec.describe 'admin/articles/index', type: :view do
  let(:user) { create(:user) } 

  before do
    @articles = [
      create(:article, user: user, status: 'approved', title: 'Approved Article'),
      create(:article, user: user, status: 'pending', title: 'Pending Article'),
      create(:article, user: user, status: 'declined', title: 'Declined Article')
    ]

    render
  end

  it 'displays the article list' do
    expect(rendered).to have_content('Article List')
  end

  it 'displays the table headers' do
    expect(rendered).to have_content('Author')
    expect(rendered).to have_content('Title')
    expect(rendered).to have_content('Action')
  end

  it 'displays article details for each article' do
    @articles.each do |article|
      expect(rendered).to have_content(article.user.name)
      expect(rendered).to have_content(article.title)
    end
  end

  it 'displays the correct status and buttons for each article' do
    @articles.each do |article|
      if article.status == 'approved'
        expect(rendered).to have_content('Status: Approved')
      elsif article.status == 'declined'
        expect(rendered).to have_content('Status: Declined')
      else
        expect(rendered).to have_content('Status: Pending')
        expect(rendered).to have_link('Approve', href: approve_article_path(article))
        expect(rendered).to have_link('Decline', href: decline_article_path(article))
      end
    end
  end

  it 'displays the view link for each article' do
    @articles.each do |article|
      expect(rendered).to have_link('View', href: article_path(article))
    end
  end
end

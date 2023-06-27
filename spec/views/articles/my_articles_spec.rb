require 'rails_helper'

RSpec.describe "articles/my_articles", type: :view do
  let(:user) { create(:user) } 
  let(:articles) { create_list(:article, 3, user: user) } 

  before do
    assign(:articles, articles)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it "displays the articles" do
    articles.each do |article|
      expect(rendered).to have_content(article.title)
      expect(rendered).to have_content(article.description)
      expect(rendered).to have_content(article.status)
      expect(rendered).to have_content("Created #{time_ago_in_words(article.created_at)} ago")

      if article.approved?
        expect(rendered).to have_link("View", href: article_path(article))
      end

      if article.approved? && article.user == user
        expect(rendered).to have_link("Edit", href: edit_article_path(article))
      end

      expect(rendered).to have_link("Delete", href: article_path(article))
    end
  end
end

require 'rails_helper'

RSpec.describe 'articles/_form.html.erb', type: :view do
  before(:each) do
    @article = Article.new
    assign(:article, @article)
  end

  it 'displays the form correctly' do
    render

    expect(rendered).to have_selector("form[action='#{articles_path}'][method='post']")
    expect(rendered).to have_selector('input[name="article[title]"][type="text"]')
    expect(rendered).to have_selector('textarea[name="article[description]"]')
    expect(rendered).to have_selector('input[name="article[tags]"][type="text"]')
    expect(rendered).to have_selector('select[name="article[category_ids][]"]')
    expect(rendered).to have_selector('input[name="article[image]"][type="file"]')
    expect(rendered).to have_selector('input[type="submit"]')
    expect(rendered).to have_link('Cancel and return to articles listing', href: articles_path)
  end
end

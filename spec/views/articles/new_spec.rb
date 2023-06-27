require 'rails_helper'

RSpec.describe 'articles/new', type: :view do
  before do
    assign(:article, Article.new)
    render
  end

  it 'displays the heading' do
    expect(rendered).to have_selector('h1', text: 'Create New Articles')
  end

  it 'renders the form partial' do
    expect(view).to render_template(partial: '_form')
  end

end

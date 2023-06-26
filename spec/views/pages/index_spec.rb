require 'rails_helper'

RSpec.describe 'pages/index.html.erb', type: :view do
  before do
    assign(:articles, []) 
    render
  end

  it 'displays the title' do
    expect(rendered).to have_selector('h1', text: 'ABOUT ALPHA BLOG')
  end

  it 'displays the description' do
    expect(rendered).to have_selector('p.lead', text: 'This is a simple hero unit')
  end

  it 'displays the content paragraph' do
    expect(rendered).to have_selector('p', text: 'It uses utility classes for typography')
  end
end

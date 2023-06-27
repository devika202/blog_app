require 'rails_helper'

RSpec.describe 'pages/index.html.erb', type: :view do
  before do
    assign(:articles, []) 
    render
  end

  it 'displays the title' do
    expect(rendered).to have_selector('h1', text: 'ABOUT BLOGGER')
  end

  it 'displays the description' do
    expect(rendered).to have_selector('p.lead', text: 'At our blogging app, we believe that everyone has a story to tell, and we are here to help you share yours. Whether you want to express your thoughts, share your knowledge, or showcase your creativity, our platform provides the perfect space for you to unleash your writing potential.')
  end

  it 'displays the content paragraph' do
    expect(rendered).to have_selector('p', text: 'Happy blogging!')
  end
end

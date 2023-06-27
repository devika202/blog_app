require 'rails_helper'

RSpec.describe 'pages/home', type: :view do
  before do
    render
  end

  it 'displays the page content' do
    expect(rendered).to have_selector('#page-content')
    expect(rendered).to have_selector('.container#home-container')
    expect(rendered).to have_selector('.jumbotron.text-center.text-white')
    expect(rendered).to have_selector('h1.display-4', text: 'Welcome to bloggers app!')
    expect(rendered).to have_selector('p.lead', text: 'Our blogging app is designed to provide you with a seamless and enjoyable writing experience. Whether you are a seasoned writer or just starting your blogging journey, our app has all the features you need to create, manage, and share your content with the world.')
    expect(rendered).to have_selector('hr.my-4')
    expect(rendered).to have_selector('p', text: 'We are dedicated to continuously improving our blogging app and providing you with the best blogging experience possible. Join us today and start sharing your stories with the world!')
    expect(rendered).to have_link('Read Blogs', href: articles_path)
    expect(rendered).to have_selector('a.btn.btn-info.btn-lg', text: 'Read Blogs')
  end
end

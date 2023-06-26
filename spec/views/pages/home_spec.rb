require 'rails_helper'

RSpec.describe 'pages/home', type: :view do
  before do
    render
  end

  it 'displays the page content' do
    expect(rendered).to have_selector('#page-content')
    expect(rendered).to have_selector('.container#home-container')
    expect(rendered).to have_selector('.jumbotron.text-center.text-white')
    expect(rendered).to have_selector('h1.display-4', text: 'Alpha Blog')
    expect(rendered).to have_selector('p.lead', text: 'This is a simple hero unit')
    expect(rendered).to have_selector('hr.my-4')
    expect(rendered).to have_selector('p', text: 'It uses utility classes')
    expect(rendered).to have_link('Sign up!', href: new_user_registration_path)
    expect(rendered).to have_selector('a.btn.btn-success.btn-lg', text: 'Sign up!')
  end
end

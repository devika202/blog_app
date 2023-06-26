require 'rails_helper'

RSpec.describe 'users/_form.html.erb', type: :view do
  let(:user) { User.new }

  before do
    assign(:user, user)
    render
  end

  it 'displays the email field' do
    expect(rendered).to have_field('user_email')
  end

  it 'displays the password field' do
    expect(rendered).to have_field('user_password')
  end

  it 'displays the submit button' do
    expect(rendered).to have_button('Sign up')
  end

  it 'displays the cancel link' do
    expect(rendered).to have_link('Cancel and return to articles listing', href: articles_path)
  end
end

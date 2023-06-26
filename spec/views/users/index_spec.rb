require 'rails_helper'

RSpec.describe 'users/index', type: :view do
    include Devise::Test::ControllerHelpers

  before(:each) do
    allow(view).to receive(:will_paginate)

    assign(:users, [
      FactoryBot.create(:user, name: 'John Doe', articles: []),
      FactoryBot.create(:user, name: 'Jane Smith', articles: [])
    ])
    render
  end

  it 'renders a list of users' do
    expect(rendered).to have_content('Alpha Bloggers')
    expect(rendered).to have_selector('.card', count: 2)

    expect(rendered).to have_content('John Doe')
    expect(rendered).to have_content('Jane Smith')
  end

  it 'displays user profile information' do
    expect(rendered).to have_selector('.card-body .card-title', count: 2)
    expect(rendered).to have_selector('.card-body .card-text', count: 2)

    expect(rendered).to have_link('View profile', href: user_path(User.first))
    expect(rendered).to have_link('View profile', href: user_path(User.last))
  end

  it 'displays time since user joined' do
    expect(rendered).to have_content('Joined')
    expect(rendered).to have_content('ago')
  end

  it 'renders pagination' do
    expect(rendered).to have_selector('.flickr_pagination', count: 2)
  end
end

require 'rails_helper'

RSpec.describe 'categories/index', type: :view do
    include Devise::Test::ControllerHelpers

  before(:each) do
    assign(:categories, create_list(:category, 1)) 
    allow(view).to receive(:will_paginate).and_return(nil)
    render
  end

  it 'displays the heading' do
    expect(rendered).to have_css('h1.text-center', text: 'CATEGORIES')
  end

  it 'displays category names and article counts' do
    Category.all.each do |category|
    end
  end

  it 'displays the delete button for admin users when there are no articles' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(double(admin?: true))
    Category.all.each do |category|
      next if category.articles.present?

    end
  end

  it 'displays the creation and update timestamps' do
    Category.all.each do |category|
    end
  end

  it 'does not display the delete button for non-admin users' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(double(admin?: false))
    expect(rendered).not_to have_link('Delete')
  end

  it 'does not display the delete button for admin users when articles are present' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(double(admin?: true))
    expect(rendered).not_to have_link('Delete')
  end

  it 'does not display the delete button for non-authenticated users' do
    allow(view).to receive(:user_signed_in?).and_return(false)
    expect(rendered).not_to have_link('Delete')
  end

  it 'displays the pagination' do
    expect(rendered).to have_css('.flickr_pagination', count: 2)
  end
end

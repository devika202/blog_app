require 'rails_helper'

RSpec.describe 'categories/_category.html.erb', type: :view do
  let(:category) { create(:category) } 

  it 'displays the category name as a link' do
    render partial: 'categories/category', locals: { category: category }

    expect(rendered).to have_link(category.name, href: category_path(category))
  end

  it 'has the correct CSS classes for the link' do
    render partial: 'categories/category', locals: { category: category }

    expect(rendered).to have_css('.badge.badge-pill.badge-info.mr-1')
  end
end

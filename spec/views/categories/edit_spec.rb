require 'rails_helper'

RSpec.describe 'categories/edit', type: :view do
  before do
    assign(:category, Category.new)
  end

  it 'renders the create category form' do
    render

    expect(rendered).to have_selector('h1', text: 'Create a new category')
    expect(rendered).to have_selector('.container')
    expect(rendered).to have_selector('.row.justify-content-center')
    expect(rendered).to have_selector('.col-10')
    expect(rendered).to render_template(partial: '_form')
    expect(rendered).to have_link("Cancel and return to categories", href: categories_path)
    expect(rendered).to have_selector("a.btn.btn-info.btn-lg", text: "Cancel and return to categories")
    expect(rendered).to have_selector("a.btn.btn-info.btn-lg[style='width: 314px;']")
  end
end

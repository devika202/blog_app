require 'rails_helper'

RSpec.describe 'categories/_form.html.erb', type: :view do
  before(:each) do
    @category = Category.new
    render partial: 'categories/form', locals: { category: @category }
  end

  it 'renders the form with the correct elements' do
    expect(rendered).to have_selector("form[action='#{categories_path}'][method='post']")

    expect(rendered).to have_selector('.form-group.row.form-label', count: 2)

    expect(rendered).to have_selector('label.col-2.col-form-label.text-light[for=category_name]', text: 'Category Name')
    expect(rendered).to have_selector('input#category_name.form-control.shadow.rounded[type=text][placeholder="Enter a name"]')

    expect(rendered).to have_selector('.form-group.row.justify-content-center.form-label', count: 1)
    expect(rendered).to have_selector('input[type=submit].btn.btn-outline-dark.btn-lg[style="width: 200px;"]')
  end
end

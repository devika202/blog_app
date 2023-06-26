require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  before(:each) do
    assign(:category, Category.new)
  end

  it "renders the edit category name form" do
    render

    expect(rendered).to have_selector("h1.text-center.mt-4", text: "Edit category name")
    expect(rendered).to have_selector("div.container")
    expect(rendered).to have_selector("div.row.justify-content-center")
    expect(rendered).to have_selector("div.col-10")
    expect(rendered).to render_template(partial: "_form")
    expect(rendered).to have_link("Cancel and return to categories", href: categories_path)
    expect(rendered).to have_selector("a.btn.btn-info.btn-lg", text: "Cancel and return to categories")
    expect(rendered).to have_selector("a.btn.btn-info.btn-lg[style='width: 314px;']")
  end
end

require 'rails_helper'

RSpec.describe "articles/index.html.erb", type: :view do
  before(:each) do
    allow(view).to receive(:will_paginate)

    assign(:articles, [ ])
    assign(:search, Ransack::Search.new(Article)) 
    assign(:categories, [ ])
  end

  it "displays the articles list" do
    render

    expect(rendered).to have_content("Articles list")
    expect(rendered).to have_selector("div.container")
    expect(rendered).to have_selector("h1.text-center", text: "Articles list")
    expect(rendered).to have_selector("div.flickr_pagination")
    expect(rendered).to have_selector("div.row.new")
    expect(rendered).to have_selector("div.col-md-3 > .form-group")
    expect(rendered).to have_selector("div.form-group > form[action='#{articles_path}'][method='get']")
    expect(rendered).to have_selector("h3", text: "Category")
    expect(rendered).to have_link("View All Article", href: articles_path, class: "btn btn-light")
    expect(rendered).to have_selector("input[type='checkbox'][name='q[categories_id_eq_any][]']", count: @categories)
    expect(rendered).to have_selector("input[type='submit'][value='FILTER'][class='btn btn-primary']")
    expect(rendered).to render_template(partial: "_article")
    expect(rendered).to have_selector("div.flickr_pagination.mb-4")
  end
end

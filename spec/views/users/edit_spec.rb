require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    assign(:user, User.new)
    render
  end

  it "displays the sign-up form" do
    expect(rendered).to have_selector("h1.text-center", text: "Edit Your Details")
    expect(rendered).to render_template(partial: "_form")
  end
end

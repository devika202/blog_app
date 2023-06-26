require 'rails_helper'

RSpec.describe 'shared/_errors.html.erb', type: :view do
  let(:obj) { double('object') }

  before do
    allow(obj).to receive(:present?).and_return(true)
    allow(obj).to receive_message_chain(:errors, :any?).and_return(true)
    allow(obj).to receive_message_chain(:class, :name).and_return('ObjectClass')
    allow(obj).to receive_message_chain(:errors, :full_messages).and_return(['Error message 1', 'Error message 2'])

    render partial: 'shared/errors', locals: { obj: obj }
  end

  it 'displays the error messages' do
    expect(rendered).to have_selector('.alert.alert-danger')
    expect(rendered).to have_selector('h4.alert-heading', text: 'The following errors prevented the objectclass from being saved')
    expect(rendered).to have_selector('li', text: 'Error message 1')
    expect(rendered).to have_selector('li', text: 'Error message 2')
  end

  it 'renders the close button' do
    expect(rendered).to have_selector('button.btn-close')
  end
end

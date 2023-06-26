require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'abstract_class' do
    it 'is set to true' do
      expect(ApplicationRecord.abstract_class).to be_truthy
    end
  end
end
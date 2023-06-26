RSpec.describe Like, type: :model do
    describe 'associations' do
      it { should belong_to(:user).optional }
      it { should belong_to(:article) }
    end
  end
  
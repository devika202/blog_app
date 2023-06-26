require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:comments) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'devise modules' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
  end

  describe 'default attributes' do
    it 'should have default admin value as false' do
      user = User.new
      expect(user.admin).to be(false)
    end
  end
end

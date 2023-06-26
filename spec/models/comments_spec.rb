require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:article) }
    it { should belong_to(:user).optional }
  end
end

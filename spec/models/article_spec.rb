RSpec.describe Article, type: :model do
    describe "associations" do
      it { should belong_to(:user) }
      it { should belong_to(:author).class_name('User').with_foreign_key('user_id') }
      it { should have_many(:comments) }
      it { should have_many(:article_categories) }
      it { should have_many(:categories).through(:article_categories) }
      it { should have_many(:likes).dependent(:destroy) }
      it { should have_many(:dislikes).dependent(:destroy) }
    end
  
    describe "validations" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
      it { should validate_length_of(:title).is_at_least(6).is_at_most(100) }
      it { should validate_length_of(:description).is_at_least(10).is_at_most(30000) }
      it { should validate_presence_of(:category_ids) }
      it { should validate_presence_of(:image).with_message("must be attached") }
    end
  
    describe "enums" do
      it { should define_enum_for(:status).with_values(pending: 0, approved: 1, declined: 2) }
    end
  
    describe "methods" do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
  
      describe "#image_presence" do
        context "when image is attached" do
          before do
            image_path = Rails.root.join("spec", "fixtures", "sample.jpg")
            file = File.open(image_path)
            article.image.attach(io: file, filename: "sample.jpg", content_type: "image/jpeg")
          end
      
          it "does not add an error to image" do
            expect(article.errors[:image]).to be_empty
          end
        end
      
        context "when image is not attached" do
          before { article.image.purge }
      
          it "adds an error to image" do
            article.valid?
            expect(article.errors[:image]).to include("must be attached")
          end
        end
      end
      
  
      describe "#liked_by?" do
        context "when user is present and has liked the article" do
          before { create(:like, article: article, user: user) }
  
          it "returns true" do
            expect(article.liked_by?(user)).to be true
          end
        end
  
        context "when user is present but has not liked the article" do
          it "returns false" do
            expect(article.liked_by?(user)).to be false
          end
        end
  
        context "when user is not present" do
          it "returns false" do
            expect(article.liked_by?(nil)).to be false
          end
        end
      end
    end
  end
  
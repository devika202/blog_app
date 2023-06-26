FactoryBot.define do
    factory :article do
      title { 'Sample Article' }
      description { 'This is a sample article.' }
      user 
      category_ids { create_list(:category, 2).pluck(:id) }
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'sample.jpg'), 'image/jpeg') }    
    end
  end
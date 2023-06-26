FactoryBot.define do
    factory :comment do
      content { "Test comment" }
      association :article
      association :user
    end
  end
  
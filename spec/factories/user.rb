FactoryBot.define do
    factory :user do
      sequence(:email) { |n| "user#{n}@example.com" }
      password { 'administrator' }
      password_confirmation { 'administrator' }
      name { 'Devika' }
    end
  end
  
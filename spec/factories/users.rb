# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }
    password_confirmation { 'password' }
    email { Faker::Internet.email }

    trait :admin do
      admin { true }
    end
  end
end

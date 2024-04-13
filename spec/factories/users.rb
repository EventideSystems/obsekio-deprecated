# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }
    email { Faker::Internet.email }
  end
end

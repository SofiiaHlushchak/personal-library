# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "secret" }
    password_confirmation { "secret" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.unique.username(specifier: 5..10) }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end

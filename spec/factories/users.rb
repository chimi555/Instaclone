# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Chinami Shibata' }
    user_name { 'chinami' }
    sequence(:email) { |n| "testr#{n}@example.com" }
    password { 'foobar' }
    profile { 'hello' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'Test Comment' }
    association :micropost
    association :user
  end
end

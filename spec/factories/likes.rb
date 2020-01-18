# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :micropost
    association :user
  end
end

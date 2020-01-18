FactoryBot.define do
  factory :like do
    association :micropost
    association :user
  end
end

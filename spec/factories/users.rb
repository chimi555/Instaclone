FactoryBot.define do
  factory :user, aliases: %i[owner follower followed] do
    sequence(:name) { |n| "tester#{n}" }
    sequence(:user_name) { |n| "tester#{n}_username" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'foobar' }

    profile { 'hello' }
  end
end

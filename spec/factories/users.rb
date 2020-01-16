FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'Chinami Shibata' }
    sequence(:user_name) { |n|'chinami' }
    sequence(:email) { |n| "testr#{n}@example.com" }
    password { 'foobar' }
    profile { 'hello' }
  end
end

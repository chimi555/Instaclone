User.create!(name:  "Example User",
            user_name: "Example User_username",
            email: "example@railstutorial.org",
            password:              "foobar",
            password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  user_name = "#{Faker::Name.name}_username"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              user_name: user_name,
              email: email,
              password:              password,
              password_confirmation: password)
end
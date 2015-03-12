namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:     "example@railstutorial.jp",
                       password:  "foobar",
                       password_confirmation: "foobar",
                       admin: true,
                       group_id: 1)
  5.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    group_id = 1
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 group_id: group_id)
  end
end


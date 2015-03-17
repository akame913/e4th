namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_articles
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:     "example@railstutorial.jp",
                       password:  "foobar",
                       password_confirmation: "foobar",
                       admin: true,
                       group_id: 1)
  30.times do |n|
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
  30.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+31}@railstutorial.jp"
    password  = "password"
    group_id = 2
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 group_id: group_id)
  end
  30.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+61}@railstutorial.jp"
    password  = "password"
    group_id = 3
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 group_id: group_id)
  end
end

def make_articles
  30.times do |n|
    title  = "Article group1 title-#{n+1}"
    group_id = 1
    user_id = n+1
    date = "date-#{n+1}"
    content = "Content is No.#{n+1}"
    Article.create!(title:         title,
                     group_id:      group_id,
                     user_id:       user_id,
                     date:          date,
                     content:       content)
  end
  30.times do |n|
    title  = "Article group2 title-#{n+31}"
    group_id = 2
    user_id = n+1
    date = "date-#{n+31}"
    content = "Content is No.#{n+31}"
    Article.create!(title:         title,
                     group_id:      group_id,
                     user_id:       user_id,
                     date:          date,
                     content:       content)
  end
  30.times do |n|
    title  = "Article group3 title-#{n+61}"
    group_id = 3
    user_id = n+1
    date = "date-#{n+61}"
    content = "Content is No.#{n+61}"
    Article.create!(title:         title,
                     group_id:      group_id,
                     user_id:       user_id,
                     date:          date,
                     content:       content)
  end
end

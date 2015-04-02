# encoding: utf-8

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:name)     { |n| "Person #{n}" }
    sequence(:family)   { |n| "Family #{n}" }
    sequence(:given)    { |n| "Given #{n}" }
    sequence(:maiden)   { |n| "Maiden #{n}" }
    sequence(:pobox)    { |n| "Pobox #{n}" }
    sequence(:region)   { |n| "Region #{n}" }
    sequence(:city)     { |n| "City #{n}" }
    sequence(:street)   { |n| "Street #{n}" }
    sequence(:tel)      { |n| "Tel #{n}" }
    sequence(:mobile)   { |n| "Mobile #{n}" }
    sequence(:notes)    { |n| "Notes #{n}" }   
    sequence(:email)    { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    group_id 1
    
    factory :admin do
      admin true
    end
  end

  factory :article do
    sequence(:title)      { |n| "Title #{n}" }
    group_id 1
    sequence(:user_id)    { |n| "#{n}"} 
    sequence(:date)       { |n| "#{n}"}
    sequence(:content)    { |n| "Content #{n}"}
  end
  
  factory :picture do
    image_file_name "picture.png" 
    image_content_type "image/png"
    article
    user
  end      

  factory :image do
    name "picture.png" 
    content_type "image/png"
    article
    user
  end      

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end

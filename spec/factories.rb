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
    sequence(:group_id) { |n| "#{n}"}
    
    factory :admin do
      admin true
    end
  end
end

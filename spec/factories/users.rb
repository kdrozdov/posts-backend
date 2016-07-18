FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name }
    phone { Faker::PhoneNumber.phone_number }
  end
end

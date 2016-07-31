FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name }
    phone { Faker::PhoneNumber.phone_number }
    password '123456'
    password_confirmation '123456'
  end
end

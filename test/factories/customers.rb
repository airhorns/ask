# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :customer_email do |n|
    "bob#{n}@example.com"
  end

  factory :customer do
    email {FactoryGirl.generate(:customer_email)}
    password 'password'
    password_confirmation 'password'
  end
end

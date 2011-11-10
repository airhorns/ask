# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :phone_number do |n|
    s = "+"
    10.times do
      s += rand(9).to_s
    end
    s
  end

  factory :responder do
    phone_number { FactoryGirl.generate(:phone_number) }
  end
end

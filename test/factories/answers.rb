# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :answer_text do |n|
    words = %w[ yes no maybe so ]
    words[rand 4]
  end

  sequence :rated_answer_text do |n|
    if n % 5 == 0
      rand(4) + 1
    else
      "*" * (rand(4) + 1)
    end
  end

  factory :answer do
    association :responder
    text { FactoryGirl.generate(:answer_text) }
  end

  factory :rated_answer, :parent => :answer do |answer|
    text { FactoryGirl.generate(:rated_answer_text) }
  end
end

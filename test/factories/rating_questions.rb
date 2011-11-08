# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating_question do
    text "Please rate our service out of 5 stars."
    order { FactoryGirl.generate(:question_order)}
  end

  factory :rating_question_with_answer, :parent => :rating_question do |question|
    association :rated_answer
  end

  factory :rating_question_with_survey, :parent => :rating_question do |question|
    association :survey
  end
end

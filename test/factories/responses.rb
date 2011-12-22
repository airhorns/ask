# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :response do
    association :responder
    association :survey, :factory => :survey_with_many_questions
    complete false
  end

  factory :response_to_rated_survey, :parent => :response do
    association :survey, :factory => :survey_with_one_rating_question
  end
end

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_segment do
    phone_number "+1234"
    name "A segment"
    association :survey, :factory => :survey_with_many_questions
  end
end

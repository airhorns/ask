# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_segment do
    phone_number { FactoryGirl.generate(:phone_number) }
    name "A segment"
    association :survey, :factory => :survey_with_many_questions
  end
end

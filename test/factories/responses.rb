# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :response do
    association :responder
    association :segment, :factory => :survey_segment
    complete false
  end

  factory :response_to_rated_survey, :parent => :response do |response|
    response.after_build do |response|
      response.segment.survey = FactoryGirl.build(:survey_with_one_rating_question)
    end
  end
end

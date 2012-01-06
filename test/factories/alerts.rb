# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contains_word_alert do
    options ({:keyword => 'terrible'})
  end

  factory :contains_word_alert_on_survey, :parent => :contains_word_alert do
    after_build do |alert|
      alert.subject = FactoryGirl.create(:survey_with_many_questions)
    end
  end

  factory :contains_word_alert_on_question, :parent => :contains_word_alert do
    after_build do |alert|
      survey = FactoryGirl.create(:survey_with_many_questions)
      alert.subject = survey.questions.first
    end
  end
end

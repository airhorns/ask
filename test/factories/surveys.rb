# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    name "A test survey"
    phone_number "+1234"
    active true
  end

  factory :survey_with_one_question, :parent => :survey do |survey|
    survey.after_create do |survey|
      survey.questions << Factory(:question, {:survey => survey})
    end
  end

  factory :survey_with_many_questions, :parent => :survey do |survey|
    survey.after_create do |survey|
      3.times { survey.questions << Factory(:question, :survey => survey)}
    end
  end
end

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do |survey|
    name "A test survey"
    active true
    association :customer
    finish_message "Thats it, you're done! Thanks for your feedback."
    survey.after_build do |survey|
      survey.segments << FactoryGirl.build(:survey_segment, :survey => survey)
    end
  end

  factory :survey_with_one_question, :parent => :survey do |survey|
    survey.after_create do |survey|
      survey.questions << FactoryGirl.build(:question, {:survey => survey})
    end
  end

  factory :survey_with_many_questions, :parent => :survey do |survey|
    survey.after_create do |survey|
      3.times { survey.questions << FactoryGirl.build(:question, :survey => survey)}
    end
  end

  factory :survey_with_rating_questions, :parent => :survey do |survey|
    survey.after_create do |survey|
      3.times { survey.questions << FactoryGirl.build(:rating_question, :survey => survey)}
    end
  end

  factory :survey_with_one_rating_question, :parent => :survey do |survey|
    survey.after_create do |survey|
      survey.questions << FactoryGirl.build(:rating_question, :survey => survey)
      3.times { survey.questions << Factory.build(:question, :survey => survey)}
    end
  end
end

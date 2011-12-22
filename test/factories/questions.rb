# Read about factories at http://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  sequence :question do |n|
    questions = [
      "Thanks for the rating! What did we do awesome? What can we do better?",
      "Based on your experience today, would you recommend us to a friend? (Yes or no?)",
      "Do you have any other comments or suggestions?"
    ]
    questions[n % questions.size]
  end

  sequence :question_order

  factory :question do
    association :survey
    text { FactoryGirl.generate(:question)}
    order { FactoryGirl.generate(:question_order)}
  end
end

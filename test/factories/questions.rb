# Read about factories at http://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  sequence :question do |n|
    traits = %w[ color age race gender ]
    # randomly select a name from the names array for the email, so you might get "Bob1@somewhere.com"
    "What #{traits[rand 4]} are you?"
  end

  factory :question do
    text { Factory.generate(:question)}
  end

  factory :question_with_answer, :parent => :question do |question|
    association :answer
  end
end

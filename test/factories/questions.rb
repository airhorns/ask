# Read about factories at http://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  sequence :question do |n|
    traits = %w[ color age race gender height weight pantssize animal]
    # randomly select a name from the names array for the email, so you might get "Bob1@somewhere.com"
    "What #{traits[n % traits.length]} are you?"
  end

  sequence :question_order

  factory :question do
    text { FactoryGirl.generate(:question)}
    order { FactoryGirl.generate(:question_order)}
  end
end

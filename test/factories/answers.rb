# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :answer_text do |n|
    words = %w[ yes no maybe so ]
    words[rand 4]
  end

  factory :answer do
    association :responder
    text {FactoryGirl.generate(:answer_text)}
  end

  factory :rated_answer, :parent => :answer do |answer|
    answer.after_create do |survey|
      answer.meta_data << FactoryGirl(:answer_rating_meta_data)
    end
  end
end

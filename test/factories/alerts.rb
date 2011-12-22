# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contains_word_alert do
    association :survey
  end
end

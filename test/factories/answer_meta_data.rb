# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_rating_meta_data do
    key 'rating'
    value { "#{rand 5}" }
  end
end

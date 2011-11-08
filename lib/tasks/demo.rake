Bundler.setup(:test)
require 'factory_girl'

namespace :demo do
  desc "Installs some random data"
  task :install => [:environment, 'db:reset'] do
    customer = Customer.create!(email: "harry.brundage@gmail.com", password: "password", password_confirmation: 'password')
    2.times do
      survey = FactoryGirl.create(:survey_with_one_rating_question)
      20.times do
        response = FactoryGirl.create(:response, :survey => survey)
        response.step!("#{rand 5}") # Answer the rating
        while response.step!(FactoryGirl.generate(:answer_text))
          true
        end
      end
    end
  end
end

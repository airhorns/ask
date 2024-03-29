Bundler.setup(:test)

namespace :demo do
  desc "Installs some random data"
  task :install => [:environment, 'db:reset'] do
    # Create a default user
    AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
    customer = Customer.create!(email: "harry.brundage@gmail.com", password: "password", password_confirmation: 'password')
    2.times do
      survey = FactoryGirl.create(:survey_with_one_rating_question, customer: customer)
      survey.segments.create!(:phone_number => "+1235", :name => "Location B")
      survey.segments.create!(:phone_number => "+1236", :name => "Location C")
      survey.segments.each do |segment|
        1.upto(30) do |i|
          Timecop.travel(Time.now - i.days) do
            (rand(15) + 5).times do
              response = FactoryGirl.create(:response, :segment => segment)
              if rand(2) == 1
                message = response.step("#{rand(5) + 1}") # Answer the rating
              else
                message = response.step("#{"*" * (rand(5) + 1)}") # Answer the rating
              end
              message.save!
              until response.complete?
                response.step(FactoryGirl.generate(:answer_text)).save!
              end
              print '.'
            end
          end
        end
      end
    end

    # Create another survey so we can test if the lines blur in the interface
    anotherCustomer = Customer.create!(email: "barry.hrundage@gmail.com", password: "password", password_confirmation: 'password')
    FactoryGirl.create(:survey_with_one_rating_question, customer: anotherCustomer)
  end
end

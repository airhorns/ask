require 'test_helper'

class TwilioSurveyTest < ActionDispatch::IntegrationTest
  setup do
    @responder = FactoryGirl.create(:responder)
  end
  test "should allow the first question to be answered" do
    @survey = FactoryGirl.create(:survey_with_many_questions)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        post "/api/twilio/receive/#{@survey.first_phone_number}.xml", {:From => @responder.phone_number, :Body => "Yes"}
      end
    end

    assert_response :success
  end

  test "should allow the last question to be answered" do
    @survey = FactoryGirl.create(:survey_with_one_question)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        post "/api/twilio/receive/#{@survey.first_phone_number}.xml", {:From => @responder.phone_number, :Body => "Yes"}
      end
    end
    assert_response :success
  end

  test "should behave if the user tries to answer more than the available questions" do
    @survey = FactoryGirl.create(:survey_with_one_question)

    post "/api/twilio/receive/#{@survey.first_phone_number}.xml", {:From => @responder.phone_number, :Body => "Yes"}
    assert_response :success
    post "/api/twilio/receive/#{@survey.first_phone_number}.xml", {:From => @responder.phone_number, :Body => "No"}
    assert_response :success
  end

  test "should error if the user tries to answer a non existant survey" do
    assert_no_difference('Response.count') do
      assert_no_difference('Answer.count') do
        post "/api/twilio/receive/404.xml", {:From => @responder.phone_number, :Body => "Yes"}
        assert_response :success
      end
    end
  end
end

require 'test_helper'

def tropo_params(from, to, body)
  {"session" => {
    "initialText" => body,
    "from" => {"id" => from.gsub(/^[0-9]/, '')},
    "to" => {"id" => to.gsub(/^[0-9]/, '')}
  }}
end

class TropoSurveyTest < ActionDispatch::IntegrationTest
  setup do
    @responder = FactoryGirl.create(:responder)
  end
  test "should allow the first question to be answered" do
    @survey = FactoryGirl.create(:survey_with_many_questions)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        post "/api/tropo/receive.json", tropo_params(@survey.phone_number, @responder.phone_number, "Yes")
      end
    end

    assert_response :success
  end

  test "should allow the last question to be answered" do
    @survey = FactoryGirl.create(:survey_with_one_question)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        post "/api/tropo/receive.json",  tropo_params(@survey.phone_number, @responder.phone_number, "Yes")
      end
    end
    assert_response :success
  end

  test "should error if the user tries to answer more than the available questions" do
    @survey = FactoryGirl.create(:survey_with_one_question)

    post "/api/tropo/receive.json",  tropo_params(@survey.phone_number, @responder.phone_number, "Yes")

    assert_response :success
    post "/api/tropo/receive.json",  tropo_params(@survey.phone_number, @responder.phone_number, "Yes")

    assert_response :success
  end

  test "should error if the user tries to answer a non existant survey" do
    post "/api/tropo/receive.json",  tropo_params("+1234", @responder.phone_number, "Yes")
    assert_response :success
  end
end


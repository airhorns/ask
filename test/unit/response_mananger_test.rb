require 'test_helper'

class ResponseManagerTest < ActiveSupport::TestCase
  setup do
    @responder = FactoryGirl.create(:responder)
  end

  test "should allow the first question to be answered" do
    @survey = FactoryGirl.create(:survey_with_many_questions)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        @manager = ResponseManager.new(@responder.phone_number, @survey.phone_number)
        @manager.step("Yes")
        assert !@manager.error?
      end
    end
  end

  test "should allow the last question to be answered" do
    @survey = FactoryGirl.create(:survey_with_one_question)

    assert_difference('Response.count') do
      assert_difference('Answer.count') do
        @manager = ResponseManager.new(@responder.phone_number, @survey.phone_number)
        assert !@manager.finished?
        @manager.step("Yes")
        assert !@manager.error?
        assert @manager.finished?
      end
    end
  end

  test "should error if the user tries to answer more than the available questions" do
    @survey = FactoryGirl.create(:survey_with_one_question)
    @manager = ResponseManager.new(@responder.phone_number, @survey.phone_number)
    @manager.step("Yes")
    @manager.step("Yes")
    assert @manager.error?
  end

  test "should error if the user tries to answer a non existant survey" do
    @manager = ResponseManager.new(@responder.phone_number, "+1404")
    assert @manager.error?
  end

  test "should error if the user gives an invalid rating for a rated question" do
    @survey = FactoryGirl.create(:survey_with_one_rating_question)
    @manager = ResponseManager.new(@responder.phone_number, @survey.phone_number)
    @manager.step("10")
    assert @manager.error?

    @manager = ResponseManager.new(@responder.phone_number, @survey.phone_number)
    @manager.step("-4")
    assert @manager.error?
  end
end

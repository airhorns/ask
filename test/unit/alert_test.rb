require 'test_helper'

class AlertTest < ActiveSupport::TestCase

  def setup
    @answer = FactoryGirl.create(:answer)
    @survey = @answer.survey
  end

  def test_alert_for_answer_finds_alerts_on_the_answers_question
    @alert = FactoryGirl.create(:contains_word_alert, subject: @answer.question)
    assert_equal [@alert], Alert.for_answer(@answer).all
  end

  def test_alert_for_answer_finds_alerts_on_the_answers_survey
    @alert = FactoryGirl.create(:contains_word_alert, subject: @survey)
    assert_equal [@alert], Alert.for_answer(@answer).all
  end

  def test_alert_for_survey_finds_alerts_on_the_survey
    @alert = FactoryGirl.create(:contains_word_alert, subject: @survey)
    assert_equal [@alert], Alert.for_survey(@survey).all
  end

  def test_alert_for_survey_finds_alerts_on_the_questions
    @alertA = FactoryGirl.create(:contains_word_alert, subject: @survey.questions.first)
    @alertB = FactoryGirl.create(:contains_word_alert, subject: @survey.questions.second)
    assert_equal [@alertA, @alertB], Alert.for_survey(@survey).all
  end
end

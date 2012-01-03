require 'test_helper'

class AlertTest < ActiveSupport::TestCase

  def setup
    @answer = FactoryGirl.create(:answer)
  end

  def test_alert_for_answer_finds_alerts_on_the_answers_question
    @alert = FactoryGirl.create(:contains_word_alert, subject: @answer.question)
    assert_equal [@alert], Alert.for_answer(@answer).all
  end

  def test_alert_for_answer_finds_alerts_on_the_answers_survey
    @alert = FactoryGirl.create(:contains_word_alert, subject: @answer.survey)
    assert_equal [@alert], Alert.for_answer(@answer).all
  end

end

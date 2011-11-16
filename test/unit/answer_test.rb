require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  def setup
    @question = FactoryGirl.create(:rating_question_with_survey)
    @response = FactoryGirl.create(:response, :survey => @question.survey)
    @answer = Answer.new(:question => @question, :response => @response)
  end

  test "star answers are parsed" do
    @answer.text = "***"
    assert_equal 3, @answer.parse_rating
    @answer.text = "*"
    assert_equal 1, @answer.parse_rating
  end

  test "pound answers are parsed" do
    @answer.text = "###"
    assert_equal 3, @answer.parse_rating
    @answer.text = "##"
    assert_equal 2, @answer.parse_rating
  end

  test "integer answers are parsed" do
    @answer.text = "3"
    assert_equal 3, @answer.parse_rating
    @answer.text = "2"
    assert_equal 2, @answer.parse_rating
  end

  test "zero ratings are invalid" do
    @answer.text = "0"
    assert !@answer.save, "Answers with text '0' shouldn't save"
  end

  test "ratings > 5 are invalid" do
    @answer.text = "10"
    assert !@answer.save, "Answers with text '10' shouldn't save"
  end

  test "0 < ratings < 6 are valid" do
    @answer.text = "3"
    assert @answer.save
  end
end

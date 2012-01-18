require 'test_helper'

class SurveySegmentTest < ActiveSupport::TestCase
  def setup
    @survey = FactoryGirl.create(:survey_with_many_questions)
    FactoryGirl.create(:survey_segment, :survey => @survey)
    @survey.segments.reload
  end

  def test_for_phone_number_should_find_the_right_segment
    assert_equal @survey.segments.first, SurveySegment.for_phone_number(@survey.segments.first.phone_number)
    assert_equal @survey.segments.second, SurveySegment.for_phone_number(@survey.segments.second.phone_number)
  end
end

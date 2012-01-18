require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  def setup
    @survey = FactoryGirl.create(:survey_with_many_questions)
    @segment = @survey.segments.first
    @responder = FactoryGirl.create(:responder)
  end

  test "a new response should be incomplete" do
    @response = Response.new(:survey => @survey, :responder => @responder)
    assert !@response.complete?
  end

  test "a response with answers for all its questions should be complete" do
    @response = Response.new(:survey => @survey, :responder => @responder)
    @response.save!
    @survey.questions.count.times do
      assert @response.step("Yes").save
    end
    assert @response.complete?
  end

  test "for_segment_and_responder generates a new response if one doesn't yet exist" do
    @response = Response.for_segment_and_responder(@segment, @responder)
    assert @response.persisted?
    assert !@response.complete?
    assert_equal @response.segment, @segment
  end

  test "for_segment_and_responder generates a new response for a different segment of the same survey" do
    @segment_two = FactoryGirl.create(:survey_segment, :survey => @survey)
    @segment_three = FactoryGirl.create(:survey_segment, :survey => @survey)
    initial_response = Response.for_segment_and_responder(@segment, @responder)
    assert_equal initial_response.segment, @segment
    second_response = Response.for_segment_and_responder(@segment_two, @responder)
    assert_equal second_response.segment, @segment_two
    third_response = Response.for_segment_and_responder(@segment_three, @responder)
    assert_equal third_response.segment, @segment_three
  end

  test "for_segment_and_responder finds an existing incomplete response" do
    @response = Response.for_segment_and_responder(@segment, @responder)
    next_response = Response.for_segment_and_responder(@segment, @responder)
    assert_equal @response, next_response
  end

  test "for_segment_and_responder finds an existing incomplete response if some questions have been answered" do
    @response = Response.for_segment_and_responder(@segment, @responder)
    assert @response.step("Yes")
    next_response = Response.for_segment_and_responder(@segment, @responder)
    assert_equal @response, next_response
  end

  test "for_segment_and_responder generates a new incomplete response if only complete responses exist" do
    @response = Response.for_segment_and_responder(@segment, @responder)
    until @response.complete?
      assert @response.step("Yes").save
    end
    assert @response.complete?
    next_response = Response.for_segment_and_responder(@segment, @responder)
    assert_not_equal @response, next_response
  end
end

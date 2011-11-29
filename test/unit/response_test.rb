require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  def self.for_survey_and_responder(survey, responder)
    attrs = {:survey_id => survey.id, :responder_id => responder.id}
    existing = self.incomplete.where(attrs).first
    if !existing.nil?
      existing
    else
      self.create(attrs)
    end
  end

  def setup
    @survey = FactoryGirl.create(:survey_with_many_questions)
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

  test "for_survey_and_responder generates a new response if one doesn't yet exist" do
    @response = Response.for_survey_and_responder(@survey, @responder)
    assert @response.persisted?
    assert !@response.complete?
  end

  test "for_survey_and_responder finds an existing incomplete response" do
    @response = Response.for_survey_and_responder(@survey, @responder)
    next_response = Response.for_survey_and_responder(@survey, @responder)
    assert_equal @response, next_response
  end

  test "for_survey_and_responder finds an existing incomplete response if some questions have been answered" do
    @response = Response.for_survey_and_responder(@survey, @responder)
    assert @response.step("Yes")
    next_response = Response.for_survey_and_responder(@survey, @responder)
    assert_equal @response, next_response
  end

  test "for_survey_and_responder generates a new incomplete response if only complete responses exist" do
    @response = Response.for_survey_and_responder(@survey, @responder)
    until @response.complete?
      assert @response.step("Yes").save
    end
    assert @response.complete?
    next_response = Response.for_survey_and_responder(@survey, @responder)
    assert_not_equal @response, next_response
  end
end

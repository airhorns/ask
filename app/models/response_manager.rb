class ResponseManager
  attr_reader :survey, :responder, :response, :message, :segment

  def initialize(from, to)
    @error = false
    @responder = Responder.find_or_create_by_phone_number(from)
    @segment = SurveySegment.for_phone_number(to)
    if @segment.present?
      @survey = @segment.survey
      @response = Response.for_segment_and_responder(@segment, @responder)
    else
      @error = true
    end
  end

  def step(body)
    @message = if !@survey.nil?
      @answer = @response.step(body)
      if !@answer.nil?
        if @answer.save
          if finished?
            @survey.finish_message
          else
            next_question.text
          end
        else
          @error = true
          if @answer.errors[:rating]
            "Sorry, we couldn't understand your rating. It should be a number between 1-5 or 1-5 asterixes."
          else
            "Sorry, there was an error understanding your message. Please try again!"
          end
        end
      else
        @error = true
        "Sorry, you've already answered all the questions!"
      end
    else
      @error = true
      "Sorry, the survey you're trying to fill out can't be found."
    end
  end

  def finished?
    next_question.nil?
  end

  def error?
    @error
  end

  def next_question
    response.next_question
  end
end

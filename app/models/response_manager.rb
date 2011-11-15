class ResponseManager
  attr_reader :survey, :responder, :response, :message

  def initialize(from, to)
    @error = false
    @responder = Responder.find_or_create_by_phone_number(from)
    @survey = Survey.active.find_by_phone_number(to)
    if @survey.present?
      @response = Response.for_survey_and_responder(survey, responder)
    else
      @error = true
    end
  end

  def step!(body)
    @message = unless survey.nil?
      if @response.step!(body)
        if finished?
          "Thanks, you're done!"
        else
          next_question.text
        end
      else
        @error = true
        "Sorry, there was an error understanding your message. Please try again!"
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

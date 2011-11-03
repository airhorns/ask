class TwilioController < ApplicationController
  respond_to :xml
  layout false

  def receive
    @responder = Responder.find_or_create_by_phone_number(params[:From])
    @survey = Survey.active.find_by_phone_number(params[:phone_number])
    if @survey.nil?
      redirect_to twilio_error_path(:message => "Sorry, the survey you're trying to fill out can't be found.", :format => :xml)
      return
    end

    @response = Response.for(@survey, @responder)
    unless @response.step!(params[:Body])
      redirect_to twilio_error_path(:message => "Sorry, you've already answered all the questions. Thanks for responding!", :format => :xml)
      return
    else
      @question = @response.next_question

      if @question.nil?
        redirect_to twilio_finished_path(:format => :xml)
      else
        respond_with @question
      end
    end
  end

  def finished
    @message = "Thanks, you're done."
    respond_with @message
  end

  def error
    @message = params[:message]
    @message ||= "Sorry, there was an error processing your response."
    respond_with @message
  end
end
class TwilioController < ApplicationController
  respond_to :xml
  layout false

  def receive
    @manager = ResponseManager.new(params[:From], params[:phone_number])
    @message = @manager.step(params[:Body])
    respond_with @message
  end
end

class TwilioController < ApplicationController
  respond_to :xml
  layout false

  def receive
    @manager = ResponseManager.new(params[:From], params[:phone_number])
    @manager.step!(params[:Body])
    @message = @manager.message
    respond_with @message
  end
end

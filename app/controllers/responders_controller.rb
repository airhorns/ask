class RespondersController < ApplicationController
  respond_to :json

  def index
    @responders = Responder.all
    respond_with @responders
  end

  def show
    @responder = Responder.find(params[:id])
    respond_with @responder
  end

  def create
    @responder = Responder.new(params[:responder])
    @responder.save
    respond_with @responder
  end

  def update
    @responder = Responder.find(params[:id])
    @responder.update_attributes(params[:responder])
    respond_with @responder
  end
end

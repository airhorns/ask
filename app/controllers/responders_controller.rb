class RespondersController < ApiController
  before_filter :authenticate_customer!

  def index
    @responders = Responder.all
    respond_with @responders
  end

  def show
    @responder = Responder.find(params[:id])
    respond_with @responder
  end

  def update
    @responder = Responder.find(params[:id])
    @responder.update_attributes(params[:responder])
    respond_with @responder
  end
end

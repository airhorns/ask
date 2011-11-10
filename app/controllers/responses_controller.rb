class ResponsesController < ApplicationController
  respond_to :json

  def index
    @responses = Survey.includes(:responses => [:responder, {:answers => [:question, :rating]}]).find(params[:survey_id]).responses.order('id DESC').limit(50)

    respond_with @responses
  end

  def show
    @response = Response.find(params[:id])
    respond_with @response
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end
end

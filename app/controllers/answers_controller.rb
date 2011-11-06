class AnswersController < ApplicationController
  respond_to :json

  def index
    @answers = Response.find(params[:response_id]).answers
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end
end

class AnswersController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_response!, :only => [:index]
  before_filter :find_and_authorize_answer!, :only => [:show, :destroy]

  def index
    @answers = @response.answers
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

  private

  def find_and_authorize_response!
    @response = Response.includes(:survey, :answers).find(params[:response_id])
    authorize_survey(@response.survey)
  end

  def find_and_authorize_answer!
    @answer = Answer.includes(:survey).find(params[:id])
    authorize_survey(@answer.survey)
  end
end

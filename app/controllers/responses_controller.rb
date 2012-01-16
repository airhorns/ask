class ResponsesController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_survey!, :only => [:index]
  before_filter :find_and_authorize_response!, :except => [:index]

  def index
    @responses = @survey.responses
    .including_survey
    .including_answers
    .order('id DESC')
    .offset(params[:offset] || 0)
    .limit(params[:limit] || 25)

    respond_with @responses
  end

  def show
    respond_with @response
  end

  def destroy
    @response.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def find_and_authorize_response!
    @response = Response.includes({:segment => :survey}).find(params[:id])
    authorize_survey(@response.survey)
  end
end
